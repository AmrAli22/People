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
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let pres = HomePresenter(homeView: homeView)
        homeView.presenter = pres
        return homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.GetPeople()        
    }
}

