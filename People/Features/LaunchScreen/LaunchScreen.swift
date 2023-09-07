//
//  LaunchScreen.swift
//  People
//
//  Created by Amr Ali on 07/09/2023.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!

    public class func buildVC() -> LaunchScreenVC {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LaunchScreenVC") as! LaunchScreenVC
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.logoImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.logoImage.alpha = 0.0
        UIView.animate(withDuration: 4.00, animations: { [weak self] in
            self?.logoImage.alpha = 1.0
            self?.logoImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { [weak self] (finished: Bool) in
            if(finished){
                //MARK: - HERE To Go Main OR Onboarding Screen
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
