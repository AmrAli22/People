//
//  ViewController.swift
//  People
//
//  Created by Amr Ali on 07/09/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tabelView: UITableView! {
        didSet {
            tabelView.delegate = self
            tabelView.dataSource = self
            tabelView.refreshControl = refreshControl
            
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            
            let nibHomePersonCell = UINib(nibName: "PersonHomeCell", bundle: nil)
            tabelView.register(nibHomePersonCell, forCellReuseIdentifier: PersonHomeCell.identifier)
        }
    }
    @IBOutlet weak var NoDataView: UIView!
    @IBOutlet weak var showBookmarkedBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.returnKeyType = UIReturnKeyType.done
        }
    }
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    let refreshControl = UIRefreshControl()
    
    var presenter : HomePresenter?
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let pres = HomePresenter(homeView: homeView)
        homeView.presenter = pres
        return homeView
    }
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BookMarkedBtn = UIBarButtonItem(title: "Bookmarked", style: .plain, target: self, action: #selector(BookMarkedPeopleTapped))
        navigationItem.rightBarButtonItem = BookMarkedBtn
        
        self.NoDataView.clipsToBounds      = true
        self.NoDataView.layer.cornerRadius = 10
        self.NoDataView.layer.borderWidth  = 0.5
        self.NoDataView.layer.borderColor  = UIColor.gray.cgColor
        
        self.showBookmarkedBtn.clipsToBounds      = true
        self.showBookmarkedBtn.layer.cornerRadius = 10

        InitPeople()
    }
    
    @objc func BookMarkedPeopleTapped() {
        guard let pres = self.presenter else { return }
        self.navigationController?.pushViewController(BookMarkedPeopleVC.buildVC(Pres: pres) , animated: true)
    }

    @objc func refreshData() {
        InitPeople()
    }
    
    func InitPeople() {
        self.presenter?.GetPeople(isRefreshData: true)
    }
    
    @IBAction func showBookMarkedPeoplePressed(_ sender: Any) {
        BookMarkedPeopleTapped()
    }
}

//MARK: - UISearchBarDelegates
extension HomeVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
