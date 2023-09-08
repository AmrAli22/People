//
//  HomeVC+TableView.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.peopleArr.count ?? 0
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
}
