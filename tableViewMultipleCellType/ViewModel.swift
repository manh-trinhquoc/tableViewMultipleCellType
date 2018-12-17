//
//  ViewModel.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

enum ProfileViewModelItemType{
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType {get}
    var rowCount: Int {get}
    var sectionTitle: String {get}
    var isCollapsed: Bool {get set}
}

extension ProfileViewModelItem {
    var rowCount: Int{
        return 1
    }
}

class ProfileViewModelNameAndPictureItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    var sectionTitle: String {
        return "Main Info"
    }
    var isCollapsed = false
    
    var pictureURL : String
    var userName: String
    
    init (pictureURL: String, userName: String){
        self.pictureURL = pictureURL
        self.userName = userName
    }
}

class ProfileViewModelAboutItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .about
    }
    
    var sectionTitle: String {
        return "About"
    }
    var isCollapsed = false
    
    var about: String
    
    init(about: String){
        self.about = about
    }
}

class ProfileViewModelEmailItem: ProfileViewModelItem{
    var type: ProfileViewModelItemType{
        return .email
    }
    
    var sectionTitle: String {
        return "Email"
    }
    var isCollapsed = false
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
}

class ProfileViewModelAttributeItem: ProfileViewModelItem{
    var type: ProfileViewModelItemType{
        return .attribute
    }
    
    var sectionTitle: String {
        return "Attributes"
    }
    var isCollapsed = false
    
    var rowCount: Int{
        return attributes.count
    }
    
    var attributes: [Attribute]
    
    init(attributes: [Attribute]) {
        self.attributes = attributes
    }
    
}

class ProfileViewModelFriendsItem: ProfileViewModelItem{
    var type: ProfileViewModelItemType{
        return .friend
    }
    
    var sectionTitle: String{
        return "Friends"
    }
    var isCollapsed = false
    
    var rowCount: Int{
        return friends.count
    }
    
    var friends: [Friend]
    
    init(friends: [Friend]) {
        self.friends = friends
    }
}

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    //call back to reload table section
    var reloadSections: ((_ section: Int) -> Void )?
    
    override init() {
        super.init()
        
        print("init mock-up data")
        guard let data = dataFromFile("ServerData"), let profile = Profile(data: data) else {
            print("return from failing to parse mock-up data")
            return
        }
        //initialization code will go here
        if let name = profile.fullName, let pictureURL = profile.pictureURL {
            let nameAndPictureItem = ProfileViewModelNameAndPictureItem(pictureURL: pictureURL, userName: name)
            items.append(nameAndPictureItem)
            
        }
        
        if let about = profile.about {
            let aboutItem = ProfileViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        
        if let email = profile.email {
            let emailItem = ProfileViewModelEmailItem(email: email)
            items.append(emailItem)
        }
        
        let attributes = profile.profileAttribute
        // we only need attributes items if attritbute is not empty
        if !attributes.isEmpty {
            let attributeItem = ProfileViewModelAttributeItem(attributes: attributes)
            items.append(attributeItem)
        }
        
        let friends = profile.friends
        if !friends.isEmpty {
            let friendItem = ProfileViewModelFriendsItem(friends: friends)
            items.append(friendItem)
        }
        
    }
}

extension ProfileViewModel: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        //print("number of Sections \(items.count)")
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        if item.isCollapsed {
            print("numberOfRow In Section: 0")
            return 0
        }
        //print("number of row in section: \(item.rowCount)")
        return item.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure cell here
        let item = items[indexPath.section]
        
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DRHNameAndPictureCell.identifier, for: indexPath) as? DRHNameAndPictureCell {
                cell.item = item
                print("create cell nameAndpicture")
                return cell
            }
        
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailAndAboutCell.identifier, for: indexPath) as? EmailAndAboutCell {
                cell.item = item
                print("create cell about")
                return cell
            }
        case .email:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmailAndAboutCell.identifier, for: indexPath) as? EmailAndAboutCell {
                cell.item = item
                print("create cell email")
                return cell
            }
        case .friend:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DRHNameAndPictureCell.identifier, for: indexPath) as? DRHNameAndPictureCell {
                if let friendItem = item as? ProfileViewModelFriendsItem {
                    cell.friendItem = friendItem.friends[indexPath.row]
                }
                print("create cell friend")
                return cell
            }
            
        case .attribute:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.identifier, for: indexPath) as? AttributeCell {
                //cell.item = attributes[indexPath.row]
                if let attributeItem = item as? ProfileViewModelAttributeItem {
                    cell.item = attributeItem.attributes[indexPath.row]
                }
                print("create cell attribute")
                return cell
            }
 
        default:
            print("creat cell default")
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    /*
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return items[section].sectionTitle
    }
    */
    
    
}

public func dataFromFile (_ fileName: String) -> Data? {
    @objc class TestClass: NSObject {}
    
    let bundle = Bundle (for: TestClass.self)
    if let path = bundle.path(forResource: fileName, ofType: "json"){
        return (try? Data(contentsOf:URL( fileURLWithPath: path)))
    }
    return nil
}


extension ProfileViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("invoke tableView: view For Header In Section")
        
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView{
            
         //headerView.item = items[section]
         headerView.section = section
         headerView.delegate = self
 
         print("return from ViewFOrHeaderInSection with successful")
         return headerView
         
         }
 
        print("return from Viewfor HeaderInSection with fail")
        
        return UIView()
    }
    
}

extension ProfileViewModel: HeaderViewDelegate{
    func toggleSelection(header: HeaderView, section: Int) {
        var item = items[section]
        
        let collapsed = !item.isCollapsed
        item.isCollapsed = collapsed
        header.setCollapsed(collapsed: collapsed)
        
        //adjust the number of row inside a section
        reloadSections?(section)
    }
    
    
}
