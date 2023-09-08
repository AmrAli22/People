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
   
    //MARK: - PresenterConstractours
    init(homeView: HomeView ) {
        self.homeView = homeView
    }

    //MARK: - GetPeople
    func GetPeople(){
        self.homeView?.showSpinner()
        
        homeInteractor.getPeople() { [weak self] (peopleData, error) in
            guard let self = self else { return }
            self.homeView?.hideSpinner()

            if let peopleData = peopleData?.results {
                self.peopleArr = peopleData
                self.homeView?.reloadTableView()
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
            outputFormatter.dateFormat = "yyyy/MM/dd"
            // Convert the date to the desired format
            let formattedDate = outputFormatter.string(from: date)
            print(formattedDate)
            return("\(formattedDate)")
        } else {
            print("Invalid date format")
            return("-")
        }
    }
    
    //MARK: - ConfigureHomePersonCell
    
    func ConfigureHomePersonCell(cell: HomePersonCellCellView ,indexPath : Int){
        
        //MARK: - Configure Name
        let currentItemName = peopleArr[indexPath].name
        let NameTitle = (currentItemName?.title ?? "" )
        let FirstName = (currentItemName?.first ?? "" )
        let lastName  = (currentItemName?.last ?? "" )
        let name = NameTitle + " " + FirstName + " " + lastName
        cell.setName(name: name)
        
        //MARK: - Configure DOB
        let currentItemDOB         = peopleArr[indexPath].dob?.date ?? "-"
        let StringOfCurrentItemDOB = ConfigureDataFormat(dateString: currentItemDOB)
        cell.setDOB(DOB: StringOfCurrentItemDOB)
        
        //MARK: - Configure Location
        let currentItemLocation    = peopleArr[indexPath].location
        let LocationCity           = currentItemLocation?.city ?? ""
        let LocationCountry        = currentItemLocation?.country ?? ""
        let locationString         = "\(LocationCity)" + " " + "\(LocationCountry)"
        cell.setLocation(Location: locationString)
        
        //MARK: - Configure Mail
        let currentItemMail        = peopleArr[indexPath].email ?? ""
        cell.setEmail(email: currentItemMail)
        
        //MARK: - Configure UserImage
        let currentItemthumbnail   = peopleArr[indexPath].picture?.thumbnail ?? ""
        cell.setImageUrl(Url: currentItemthumbnail )
    }
    
  
}
