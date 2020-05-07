//
//  instantiateViewController.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/26/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation
import UIKit
struct TableViewNib {
    static let tableNibIdentifier = "TableViewCell"
}
struct Cells {
    static let cellIdentifier = "TableNib"
}
struct Instantiate {
    static let signupVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
    static let signinVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
    static let profileVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
    static let moviesVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesListVC") as! MoviesListVC
    static let mapVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        static let MoviesDetil = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesDetil") as! MoviesDetil
}
struct VCs {
    static let signupVC = "SignUpVC"
    static let signinVC =  "SignInVC"
    static let profileVC = "ProfileVC"
    static let moviesVC = "MoviesListVC"
    static let mapVC = "MapViewController"
    static let tabBar = "tab"
}
struct Storybords {
    static let main = "Main"
}
