//
//  SQLiteImage.swift
//  MoviesApp
//
//  Created by Divo Ayman on 4/30/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation
import SQLite
import UIKit
struct SQLiteURl {
    
    static var database : Connection!
    static let profileTable = Table("profileImage")
    static let profileUrl = Expression<String>("profileUrl")
    
    static func createTable( ){
        let createTable = self.profileTable.create { (table) in
            table.column(self.profileUrl)
            
        }
        
        do{
            try self .database.run(createTable)
            print("table Done")
        } catch {
            print(error)
        }
    }
    
    static  func openDataBase( ) {
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("profileImage").appendingPathExtension("sqlite3")
            let dataBase = try Connection(fileUrl.path)
            self.database = dataBase
        }
        catch {
            print(error)
        }
    }
    
 static func convertImageToBase64String (img: UIImage) -> String {
    let imageData = img.jpegData(compressionQuality: 0.75)
    let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
    print(imageStr,"imageString")
    return imageStr
    }
    
    static func insertTable(profileUrl: String) {
        let insertUser = self.profileTable.insert(self.profileUrl <- profileUrl)
        do {
            try self.database.run(insertUser)
            try self.database.run(insertUser)
            print("INSERTED Url")
        } catch {
            print(error)
        }
    }
    
   static func base64Convert(imageString: String?) -> UIImage{
    let imageData = Data(base64Encoded: imageString ?? "error", options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData) ?? UIImage(named: Images.defaultProfileImg)!
        }
    
    static func returnDataSaved( )-> String{
        var imageName = " "
        do {
            let users = try self.database.prepare(self.profileTable)
            for user in users {
                imageName = user[self.profileUrl]
            }
        } catch {
            print(error)
        }
        return imageName
    }
}
