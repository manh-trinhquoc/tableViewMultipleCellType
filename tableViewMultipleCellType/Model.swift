//
//  ViewController.swift
//  tableViewMultipleCellType
//
//  Created by trinhquocmanh-mac 10.12 on 12/14/18.
//  Copyright © 2018 trinhquocmanh-mac 10.12. All rights reserved.
//

import UIKit

class Profile {
    var fullName: String?
    var pictureURL: String?
    var email: String?
    var about: String?
    var friends = [Friend]()
    var profileAttribute = [Attribute]()
    
    init? (data:Data){
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any]{
                self.fullName = body["fullName"] as? String
                self.pictureURL = body["pictureUrl"] as? String
                self.about = body["about"] as? String
                self.email = body["email"] as? String
                
                if let friends = body["friends"] as? [[String: Any]] {
                    self.friends = friends.map {Friend(json:$0)}
                }
                
                if let profileAttributes = body["profileAttributes"] as? [[String: Any]]{
                    self.profileAttribute = profileAttributes.map{Attribute(json:$0)}
                }
            }
        } catch {
            print("Error deserializing \(error)")
            return nil
        }
    }
}

class Friend {
    var name: String?
    var pictureURL: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.pictureURL = json["pictureUrl"] as? String
    }
}


class Attribute {
    var key: String?
    var value: String?
    
    init(json: [String:Any]) {
        self.key = json["key"] as? String
        self.value = json["value"] as? String
    }
}

