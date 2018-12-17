//
//  ViewController.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = ProfileViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("invoke viewDidLoad")
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.register(DRHNameAndPictureCell.nib, forCellReuseIdentifier: DRHNameAndPictureCell.identifier)
        
        tableView.register(EmailAndAboutCell.nib, forCellReuseIdentifier: EmailAndAboutCell.identifier)
        tableView.register(AttributeCell.nib, forCellReuseIdentifier: AttributeCell.identifier)
        
        tableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        /*
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }*/
        print("return from ViewdidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




