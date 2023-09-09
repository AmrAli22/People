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
    
    @IBOutlet weak var searchBar: UISearchBar!
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
        
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = UIReturnKeyType.done
        
        let BookMarkedBtn = UIBarButtonItem(title: "BookMarked", style: .plain, target: self, action: #selector(BookMarkedPeopleTapped))
        navigationItem.rightBarButtonItem = BookMarkedBtn
        
        self.presenter?.GetPeople(isRefreshData: true)
    }
    
    
    @objc func BookMarkedPeopleTapped() {
        guard let pres = self.presenter else { return }
        self.navigationController?.pushViewController(BookMarkedPeopleVC.buildVC(Pres: pres ) , animated: true)
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

extension HomeVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // Return true to allow the keyboard to be dismissed.
        return true
    }
}
