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
            }
        }
    }
  
}
