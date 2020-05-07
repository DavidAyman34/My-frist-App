//
//  DataBaseHelper.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/27/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//
//import CoreData
//import UIKit
//import Foundation
//class DataBaseHelper {
//    static let shareInstance = DataBaseHelper()
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    func saveImage(data: Data) {
//        let imageInstance = Image(context: context)
//        imageInstance.img = data
//        do {
//            try context.save()
//            print("Image is saved")
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
