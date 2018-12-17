//
//  AttributeCell.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class AttributeCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: Attribute? {
        didSet {
            titleLabel?.text = item?.key
            valueLabel?.text = item?.value
        }
    }
    
    class var identifier: String{
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
