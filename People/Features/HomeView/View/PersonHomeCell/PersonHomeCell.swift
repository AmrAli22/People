//
//  PersonHomeCell.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit
import SDWebImage

class PersonHomeCell : UITableViewCell {

    public static let identifier = "PersonHomeCell"
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personMailLabel: UILabel!
    @IBOutlet weak var personDOBLabel: UILabel!
    @IBOutlet weak var personLocationLabel: UILabel!
    @IBOutlet weak var BookmarkBtn: UIButton!
    
    var didPressBookMarkAction     : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func BookmarkBtnPressed(_ sender: Any) {
        if let didPressBookMarkAction = didPressBookMarkAction {
            didPressBookMarkAction()
        }
    }
}

extension PersonHomeCell : HomePersonCellCellView {
    func setIsBookmark(isBookMark: Bool) {
        self.BookmarkBtn.tintColor = isBookMark ? .yellow : .gray
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
    
    
}
