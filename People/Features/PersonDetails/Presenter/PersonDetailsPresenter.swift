//
//  PersonDetailsPresenter.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import Foundation

protocol PersonDetailsView: AnyObject {
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
    
    func setName      (name      : String)
    func setDOB       (DOB       : String)
    func setLocation  (Location  : String)
    func setEmail     (email     : String)
    func setImageUrl  (Url       : String)
    func setIsBookmark(isBookMark: Bool  )
    
}

//MARK: - personDetailsPresenter
class personDetailsPresenter {
    
    //MARK: - PresenterView
    weak var personDetailsView: PersonDetailsView?
        
    //MARK: - PeopleArray
    var currentPerson : Person?
    var isBookMarked  = false
    
    //MARK: - PresenterConstractours
    init(personDetailsView: PersonDetailsView , currentPerson : Person , isbookMarked : Bool) {
        self.personDetailsView = personDetailsView
        self.currentPerson     = currentPerson
        self.isBookMarked      = isbookMarked
    }

    //MARK: - ConfigureHomePersonCell
    func ConfigurePersonDetailsView(view: PersonDetailsView ){
        //MARK: - Configure Name
        let currentItemName = currentPerson?.name
        let NameTitle = (currentItemName?.title ?? "" )
        let FirstName = (currentItemName?.first ?? "" )
        let lastName  = (currentItemName?.last ?? "" )
        let name = NameTitle + " " + FirstName + " " + lastName
        view.setName(name: name)
        
        //MARK: - Configure DOB
        let currentItemDOB         = currentPerson?.dob?.date ?? "-"
        let StringOfCurrentItemDOB = ConfigureDataFormat(dateString: currentItemDOB)
        view.setDOB(DOB: StringOfCurrentItemDOB)
        
        //MARK: - Configure Location
        let currentItemLocation    = currentPerson?.location
        let LocationCity           = currentItemLocation?.city ?? ""
        let LocationCountry        = currentItemLocation?.country ?? ""
        let locationString         = "\(LocationCity)" + ", " + "\(LocationCountry)"
        view.setLocation(Location: locationString)
        
        //MARK: - Configure Mail
        let currentItemMail        = currentPerson?.email ?? ""
        view.setEmail(email: currentItemMail)
        
        //MARK: - Configure UserImage
        let currentItemthumbnail   = currentPerson?.picture?.large ?? ""
        //MARK: - i have tried the thumbnail ,not the best apperance , so chosed the medium
        view.setImageUrl(Url: currentItemthumbnail )
        
        //MARK: - Configure IsBookmark
        view.setIsBookmark(isBookMark: self.isBookMarked)
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
    
    //MARK: - getCurrentPersonPhoneNumber
    func getCurrentPersonPhoneNumber() -> String {
        return currentPerson?.phone ?? ""
    }
    
    //MARK: - getCurrentPersonEmail
    func getCurrentPersonEmail() -> String {
        return currentPerson?.email ?? ""
    }
    
    //MARK: - getCurrentPersonLatAndLong
    func getCurrentPersonLatAndLong() -> (String,String) {
        let lat  = currentPerson?.location?.coordinates?.latitude ?? ""
        let long = currentPerson?.location?.coordinates?.latitude ?? ""
        return(lat,long)
    }
    
}
