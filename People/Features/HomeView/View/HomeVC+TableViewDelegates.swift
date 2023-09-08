//
//  HomeVC+TableView.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.filterPeopleArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let HomePersonCell = tableView.dequeueReusableCell(withIdentifier: PersonHomeCell.identifier , for: indexPath) as! PersonHomeCell
        HomePersonCell.selectionStyle = .none
        presenter?.ConfigureHomePersonCell(cell: HomePersonCell, indexPath: indexPath.row)
        return HomePersonCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(PersonDetailsVC.buildVC(), animated: true)
    }
    
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
       let islod = self.presenter?.isLoadingData ?? false
        
        if contentOffsetY + screenHeight >= contentHeight - 100 && !islod {
            self.presenter?.GetPeople()
        }
    }
}
