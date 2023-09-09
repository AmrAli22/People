//
//  PersonDetailsVC+PresenterProtcolos.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
import SDWebImage

extension PersonDetailsVC: PersonDetailsView {
 

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
    
    func setName(name: String)          {
        personNameLabel.text     = name
    }
    
    func setDOB(DOB: String)            {
        personDOBLabel.text      = DOB
    }
    
    func setLocation(Location: String)  {
        personLocationLabel.text = Location
    }
    
    func setEmail(email: String)        {
        personMailLabel.text     = email
    }
    
    func setImageUrl(Url: String)       {
        personImage.sd_setImage(with: URL(string: Url ), placeholderImage: UIImage(systemName: "person.circle.fill"))
    }
    
    func setIsBookmark(isBookMark: Bool) {
        self.BookMarkBtn.tintColor = isBookMark ? .yellow : .gray
    }
    
    
}
