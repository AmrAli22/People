//
//  HomeVC+TableView.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getPeopleCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let HomePersonCell = tableView.dequeueReusableCell(withIdentifier: PersonHomeCell.identifier , for: indexPath) as! PersonHomeCell
            HomePersonCell.selectionStyle = .none
        presenter?.ConfigureHomePersonCell(cell: HomePersonCell, indexPath: indexPath.row)
            HomePersonCell.didPressBookMarkAction = { [weak self] in
                guard let self = self else{ return }
                self.presenter?.didPressBookMarkAction(index: indexPath.row, settedFlag: nil)
            }
        return HomePersonCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedPerson = self.presenter?.getPersonByIndex(index : indexPath.row) else{
            self.FailureAlert(with: "error fetching user details")
            return
        }
        let checkIsBookMarked = self.presenter?.checkIfIndexIsBookMarked(index: indexPath.row) ?? false
        
        let storyboard = UIStoryboard(name: "PersonDetails", bundle: nil)
        let personDetailsView = storyboard.instantiateViewController(withIdentifier: "PersonDetailsVC") as! PersonDetailsVC
        let pres = personDetailsPresenter(personDetailsView: personDetailsView, currentPerson: selectedPerson , isbookMarked: checkIsBookMarked)
            personDetailsView.presenter = pres
  
        personDetailsView.didPressBookMarkAction = { [weak self] bookMarked in
            self?.presenter?.didPressBookMarkAction(index: indexPath.row , settedFlag : bookMarked)
        }
        self.navigationController?.pushViewController(personDetailsView , animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCellToShow = (self.presenter?.getPeopleCount() ?? 0) - 2
        let islod = self.presenter?.isLoadingData ?? false

        if (indexPath.row == lastCellToShow) && !islod {
            self.presenter?.GetPeople()
        }
    }
}

//extension HomeVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let screenHeight = scrollView.frame.size.height
//        
//        let islod = self.presenter?.isLoadingData ?? false
//        
//        if contentOffsetY + screenHeight >= contentHeight - 100 && !islod {
//            self.presenter?.GetPeople()
//        }
//    }
//}
