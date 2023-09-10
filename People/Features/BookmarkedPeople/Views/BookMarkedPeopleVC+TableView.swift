//
//  BookMarkedPeopleVC+TableView.swift
//  People
//
//  Created by Amr Ali on 10/09/2023.
//

import UIKit
extension BookMarkedPeopleVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getBookMarkedPeopleCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let HomePersonCell = tableView.dequeueReusableCell(withIdentifier: PersonHomeCell.identifier , for: indexPath) as! PersonHomeCell
            HomePersonCell.selectionStyle = .none
        presenter?.ConfigureBookMarkedPersonCell(cell: HomePersonCell, indexPath: indexPath.row)
            HomePersonCell.didPressBookMarkAction = { [weak self] in
                guard let self = self else{ return }
                self.presenter?.didPressBookMarkAction(index: indexPath.row , isFromBookMarkedVC: true, settedFlag: nil)
                self.tabelView.reloadData()
            }
        return HomePersonCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
