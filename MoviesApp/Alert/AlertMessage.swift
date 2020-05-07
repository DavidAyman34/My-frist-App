//
//  AlertMessage.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/19/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//
import UIKit
import Foundation
struct AlertManager {
    
    static func alert (title: String,massage: String, present : UIViewController,titleBtn: String){
        let  alertError = UIAlertController(title: title , message: massage , preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title:titleBtn, style: .default, handler: nil))
        present.self.present(alertError, animated: true)
    }
}

