//
//  PersonDetailsPresenter.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import Foundation

protocol PersonDetailsView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
}

//MARK: - personDetailsPresenter
class personDetailsPresenter {
    
    //MARK: - PresenterView
    weak var personDetailsView: PersonDetailsView?
        
    //MARK: - PeopleArray
    var currentPerson : Person?
    
    //MARK: - PresenterConstractours
    init(personDetailsView: PersonDetailsView ) {
        self.personDetailsView = personDetailsView
    }

    //MARK: - ConfigureHomePersonCell
    func ConfigurePersonDetailsView(view: PersonDetailsView ,indexPath : Int){
 
    }
}
