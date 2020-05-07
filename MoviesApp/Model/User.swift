//
//  User.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//
import Foundation
enum Gender: String,Codable {
    case male
    case female
}

struct User : Codable{
    var name : String!
    var email : String!
    var passWord: String!
    var addres : String!
    var phone: String!
    var isLogin: Bool!
    var gender : Gender!
}
