//
//  ViewController.swift
//  People
//
//  Created by Amr Ali on 07/09/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    
    var presenter : HomePresenter?
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    let refreshControl = UIRefreshControl()
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let pres = HomePresenter(homeView: homeView)
        homeView.presenter = pres
        return homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.presenter?.GetPeople(isRefreshData: true)
    }
    
    func setupTableView(){
        
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.refreshControl = refreshControl
        
        let nibHomePersonCell = UINib(nibName: "PersonHomeCell", bundle: nil)
        tabelView.register(nibHomePersonCell, forCellReuseIdentifier: PersonHomeCell.identifier)
    }
    
    @objc func refreshData() {
        self.presenter?.GetPeople(isRefreshData: true)        
    }
    
}

