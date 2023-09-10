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
        self.presenter?.getPeopleFromUserDefaults()
    }

    
    func setupTableView(){
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        let nibHomePersonCell = UINib(nibName: "PersonHomeCell", bundle: nil)
        tabelView.register(nibHomePersonCell, forCellReuseIdentifier: PersonHomeCell.identifier)
    }
    
}


