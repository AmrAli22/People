//
//  HomePresenter.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import Foundation

protocol HomeView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func reloadTableView()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
    
}

protocol HomePersonCellCellView: AnyObject {
    func setName     (name      : String)
    func setDOB      (DOB       : String)
    func setLocation (Location  : String)
    func setEmail    (email     : String)
    func setImageUrl (Url       : String)
}

//MARK: - HomePresenter
class HomePresenter {
    
    //MARK: - PresenterView
    weak var homeView: HomeView?
    
    //MARK: - PresenterInteractor
    let homeInteractor = HomeInteractor()
    
    //MARK: - PeopleArray
    var peopleArr = [Person]()
    var filterPeopleArr = [Person]()
    
    //MARK: - Pagination Vars
    var currentPage = 0
    var isLoadingData = false
    var pageSize = 25 // Adjust this as needed
    var shouldLoadMoreData = true
    var currentSeed = ""
    
    //MARK: - searchText
    var searchText = "" {
        didSet{
            searchBarChanged()
        }
    }
    
    //MARK: - PresenterConstractours
    init(homeView: HomeView ) {
        self.homeView = homeView
    }
    
    //MARK: - GetPeople
    func GetPeople(isRefreshData: Bool = false){
        
        if isRefreshData {
            currentPage = 0
        }
        
        guard !isLoadingData, shouldLoadMoreData else {
            return
        }
        
        isLoadingData = true
        
        self.homeView?.showSpinner()
        
        homeInteractor.getPeople(page: currentPage, seed: currentSeed ) { [weak self] (peopleData, error) in
            guard let self = self else { return }
            self.homeView?.hideSpinner()
            self.isLoadingData = false
            
            if let peopleData = peopleData?.results {
                if peopleData.isEmpty {
                    self.shouldLoadMoreData = false
                } else {
                    if isRefreshData {
                        self.peopleArr        = peopleData
                        self.filterPeopleArr  = peopleData
                        self.homeView?.reloadTableView()
                    }else{
                        self.peopleArr       += peopleData
                        self.currentPage     += 1
                        self.searchBarChanged()
                    }
                }
            }
        }
    }
    
    //MARK: - ConfigureDataFormat
    func ConfigureDataFormat(dateString: String ) -> String {
        // Create a date formatter for the input format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        // Parse the input date string
        if let date = inputFormatter.date(from: dateString) {
            // Create a date formatter for the desired output format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            // Convert the date to the desired format
            let formattedDate = outputFormatter.string(from: date)
            return("\(formattedDate)")
        } else {
            print("Invalid date format")
            return("-")
        }
    }
    
    //MARK: - ConfigureHomePersonCell
    func ConfigureHomePersonCell(cell: HomePersonCellCellView ,indexPath : Int){
        
        //MARK: - Configure Name
        let currentItemName = filterPeopleArr[indexPath].name
        let NameTitle = (currentItemName?.title ?? "" )
        let FirstName = (currentItemName?.first ?? "" )
        let lastName  = (currentItemName?.last ?? "" )
        let name = NameTitle + " " + FirstName + " " + lastName
        cell.setName(name: name)
        
        //MARK: - Configure DOB
        let currentItemDOB         = filterPeopleArr[indexPath].dob?.date ?? "-"
        let StringOfCurrentItemDOB = ConfigureDataFormat(dateString: currentItemDOB)
        cell.setDOB(DOB: StringOfCurrentItemDOB)
        
        //MARK: - Configure Location
        let currentItemLocation    = filterPeopleArr[indexPath].location
        let LocationCity           = currentItemLocation?.city ?? ""
        let LocationCountry        = currentItemLocation?.country ?? ""
        let locationString         = "\(LocationCity)" + ", " + "\(LocationCountry)"
        cell.setLocation(Location: locationString)
        
        //MARK: - Configure Mail
        let currentItemMail        = filterPeopleArr[indexPath].email ?? ""
        cell.setEmail(email: currentItemMail)
        
        //MARK: - Configure UserImage
        let currentItemthumbnail   = filterPeopleArr[indexPath].picture?.medium ?? ""
        //MARK: - i have tried the thumbnail ,not the best apperance , so chosed the medium
        cell.setImageUrl(Url: currentItemthumbnail )
    }
    
    //MARK: - SearchBar Delegates
    
    func searchBarChanged(){
        if searchText == "" {
            filterPeopleArr = peopleArr
        }else{
            filterPeopleArr = peopleArr.filter({ Person -> Bool in
                return ( Person.name?.first?.lowercased().contains(searchText.lowercased()) ?? false ) ||
                       ( Person.name?.last?.lowercased().contains(searchText.lowercased()) ?? false)
               })
        }
        self.homeView?.reloadTableView()
    }
    
    //MARK: - getPersonByIndex
    func getPersonByIndex(index: Int) -> Person{
        return filterPeopleArr[index]
    }
    
}
