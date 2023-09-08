//
//  HomeVC+PresenterProtocols.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
extension HomeVC : HomeView {
    func showSpinner() {
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tabelView.reloadData()
            self?.refreshControl.endRefreshing()
         }
    }
    
    func FailureAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func SuccessAlert(with msg: String) {
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
