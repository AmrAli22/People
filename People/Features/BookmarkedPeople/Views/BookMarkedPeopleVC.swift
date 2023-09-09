//
//  BookMarkedPeopleVC.swift
//  People
//
//  Created by Amr Ali on 09/09/2023.
//

import UIKit

class BookMarkedPeopleVC: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    
    var presenter : HomePresenter?
    
    public class func buildVC(Pres :HomePresenter ) -> BookMarkedPeopleVC {
        let storyboard = UIStoryboard(name: "BookmarkedPeople", bundle: nil)
        let BookMarkedPeopleVC = storyboard.instantiateViewController(withIdentifier: "BookMarkedPeopleVC") as! BookMarkedPeopleVC
        BookMarkedPeopleVC.presenter = Pres
        return BookMarkedPeopleVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    
    func setupTableView(){
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        let nibHomePersonCell = UINib(nibName: "PersonHomeCell", bundle: nil)
        tabelView.register(nibHomePersonCell, forCellReuseIdentifier: PersonHomeCell.identifier)
    }
    
}

extension BookMarkedPeopleVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.bookMarkedPeopleArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let HomePersonCell = tableView.dequeueReusableCell(withIdentifier: PersonHomeCell.identifier , for: indexPath) as! PersonHomeCell
            HomePersonCell.selectionStyle = .none
        presenter?.ConfigureBookMarkedPersonCell(cell: HomePersonCell, indexPath: indexPath.row)
            HomePersonCell.didPressBookMarkAction = { [weak self] in
                guard let self = self else{ return }
                self.presenter?.didPressBookMarkAction(index: indexPath.row , isFromBookMarkedVC: true)
                self.tabelView.reloadData()
            }
        return HomePersonCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
