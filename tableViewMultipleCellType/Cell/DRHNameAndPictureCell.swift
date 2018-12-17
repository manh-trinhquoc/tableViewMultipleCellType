//
//  DRHNameAndPictureCell.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class DRHNameAndPictureCell: UITableViewCell {

    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: ProfileViewModelItem?{
        didSet{
            if let item = item as? ProfileViewModelNameAndPictureItem {
                name?.text = item.userName
                picture?.image = UIImage(named: item.pictureURL)
            }
        }
    }
    
    var friendItem: Friend?{
        didSet {
            guard let item = friendItem else {
                return
            }
            if let pictureURL = item.pictureURL {
                picture?.image = UIImage(named: pictureURL)
            }
            name?.text = item.name
        }
    }
    
    class var identifier: String{
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

