//
//  UserResponse.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 27/06/22.
//

import Foundation


struct User : Decodable {
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
}


struct UserResponse : Decodable {
    var page : Int
    var total : Int
    var data : [User]
}
