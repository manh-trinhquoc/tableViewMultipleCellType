//
//  EmailAndAboutCell.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class EmailAndAboutCell: UITableViewCell {

    @IBOutlet var emailAndAboutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: ProfileViewModelItem? {
        didSet {
            if let item = item as? ProfileViewModelAboutItem {
                emailAndAboutLabel?.text = item.about
            }
            if let item = item as? ProfileViewModelEmailItem {
                emailAndAboutLabel?.text = item.email
            }
        }
    }
    
    class var identifier: String{
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
