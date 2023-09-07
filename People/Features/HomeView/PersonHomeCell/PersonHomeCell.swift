//
//  PersonHomeCell.swift
//  People
//
//  Created by Amr Ali on 08/09/2023.
//

import UIKit

class PersonHomeCell: UITableViewCell {

    public static let identifier = "PersonHomeCell"
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personMailLabel: UILabel!
    @IBOutlet weak var personDOBLabel: UILabel!
    @IBOutlet weak var personLocationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}