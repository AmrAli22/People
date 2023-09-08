//
//  PersonDetailsVC.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit

class PersonDetailsVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    public class func buildVC() -> PersonDetailsVC {
        let storyboard = UIStoryboard(name: "PersonDetails", bundle: nil)
        let personDetailsView = storyboard.instantiateViewController(withIdentifier: "PersonDetailsVC") as! PersonDetailsVC
//        let pres = HomePresenter(homeView: homeView)
//        homeView.presenter = pres
        return personDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        makeImageCircular()
        setupUserData()
        setupNav()
    }
    
    func setupNav() {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.gray;
    }
    
    func makeImageCircular(){
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
 
    @IBAction func callBtnPressed(_ sender: Any) {
        
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
             if UIApplication.shared.canOpenURL(phoneURL) {
                 UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
             } else {
                 // Handle the case where the device cannot make phone calls
                 print("Device cannot make phone calls")
             }
         }
        
    }
    @IBAction func emailBtnPressed(_ sender: Any) {
        
        let recipientEmail = "recipient@example.com" // Replace with the recipient's email address
          
          if let emailURL = URL(string: "mailto:\(recipientEmail)") {
              if UIApplication.shared.canOpenURL(emailURL) {
                  UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
              } else {
                  // Handle the case where the device cannot open the email app
                  print("Device cannot open the email app")
              }
          }
        
        
    }
    @IBAction func pinLocationPressed(_ sender: Any) {
        
        let latitude: Double = 37.7749 // Replace with the desired latitude
         let longitude: Double = -122.4194 // Replace with the desired longitude
         
         let alert = UIAlertController(title: "Open Location", message: "Choose a Maps App", preferredStyle: .actionSheet)
         
         // Option to open in Apple Maps
         alert.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { action in
             if let url = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)") {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
         }))
         
         // Option to open in Google Maps (if installed)
         alert.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { action in
             if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)") {
                 if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 } else {
                     // Handle the case where Google Maps is not installed
                     print("Google Maps is not installed.")
                 }
             }
         }))
         
         // Cancel option
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         
         // Present the alert
         self.present(alert, animated: true, completion: nil)
        
    }
    
}
