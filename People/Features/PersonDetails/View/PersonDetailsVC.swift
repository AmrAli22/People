//
//  PersonDetailsVC.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit

class PersonDetailsVC: UIViewController {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personMailLabel: UILabel!
    @IBOutlet weak var personDOBLabel: UILabel!
    @IBOutlet weak var personLocationLabel: UILabel!
    @IBOutlet weak var BookMarkBtn: UIButton!
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    var presenter : personDetailsPresenter?
    
    public class func buildVC(currentPerson : Person , isBookMarked : Bool) -> PersonDetailsVC {
        let storyboard = UIStoryboard(name: "PersonDetails", bundle: nil)
        let personDetailsView = storyboard.instantiateViewController(withIdentifier: "PersonDetailsVC") as! PersonDetailsVC
        let pres = personDetailsPresenter(personDetailsView: personDetailsView, currentPerson: currentPerson , isbookMarked: isBookMarked)
            personDetailsView.presenter = pres
        return personDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        makeImageCircular()
        setupNav()
        self.presenter?.ConfigurePersonDetailsView(view: self)
    }
    
    func setupNav() {
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.gray;
    }
    
    func makeImageCircular(){
        personImage.layer.borderWidth = 1.0
        personImage.layer.masksToBounds = false
        personImage.layer.borderColor = UIColor.white.cgColor
        personImage.layer.cornerRadius = personImage.frame.size.width / 2
        personImage.clipsToBounds = true
    }
 
    @IBAction func BookmarkBtnPressed(_ sender: Any) {
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
        
        guard let phoneNumber = self.presenter?.getCurrentPersonPhoneNumber() else {
            self.FailureAlert(with: "Can not get the phone number")
            return
        }
        
        if (phoneNumber != ""){
            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                 if UIApplication.shared.canOpenURL(phoneURL) {
                     UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                 } else {
                     self.FailureAlert(with: "Device cannot make phone calls")
                     return
                 }
            }else{
                self.FailureAlert(with: "Device cannot make phone calls")
                return
            }
        }else{
            self.FailureAlert(with: "Can not get the phone number")
            return
        }
    }
    @IBAction func emailBtnPressed(_ sender: Any) {
                
        guard let personEmail = self.presenter?.getCurrentPersonEmail() else {
            self.FailureAlert(with: "Can not get the person mail")
            return
        }
        
          if let emailURL = URL(string: "mailto:\(personEmail)") {
              if UIApplication.shared.canOpenURL(emailURL) {
                  UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
              } else {
                  // Handle the case where the device cannot open the email app
                  self.FailureAlert(with: "Device cannot open the email app")
                  return
              }
          }else{
              self.FailureAlert(with: "Can not get the person mail")
              return
          }
        
        
    }
    @IBAction func pinLocationPressed(_ sender: Any) {
        
        guard let latitude = self.presenter?.getCurrentPersonLatAndLong().0 else {
            self.FailureAlert(with: "Can not get the Person latitude")
            return
        }
        
        guard let longitude = self.presenter?.getCurrentPersonLatAndLong().1 else {
            self.FailureAlert(with: "Can not get the Person longitude")
            return
        }
         
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
