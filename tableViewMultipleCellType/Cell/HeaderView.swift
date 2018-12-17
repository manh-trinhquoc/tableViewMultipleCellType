//
//  HeaderView.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/17/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {


    //@IBOutlet var itemLabel: UILabel!
    
    var section: Int = 0
    
    weak var delegate: HeaderViewDelegate?
    
    var item: ProfileViewModelItem? {
        didSet {
 
            guard let item = item else {
                return
            }
            print("header Item: \(item.sectionTitle)")
            //itemLabel?.text = item.sectionTitle
            //setCollapsed(collapsed: item.isCollapsed)

        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(TapHeader)))
    }
    
    @objc private func TapHeader(gestureRecognizer: UITapGestureRecognizer){
        delegate?.toggleSelection(header: self, section: section)
    }
    
    class var identifier: String{
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}

extension HeaderView{
    func setCollapsed(collapsed: Bool){
        //arrowImage?.rotate(collapsed ? 0.0 : .pi)
    }
}

protocol HeaderViewDelegate: class {
    func toggleSelection(header: HeaderView, section: Int)
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}
