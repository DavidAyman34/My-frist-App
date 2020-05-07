//
//  DBHelper.swift
//  MoviesApp
//
//  Created by Divo Ayman on 4/2/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation
import SQLite
import UIKit
struct SQLiteManager{
    
    static var database : Connection!
    static let usersTable = Table("users")
    static let id = Expression<Int>("id")
    static let artworkUrl100 = Expression<String>("artworkUrl100")
    static let artistName =  Expression<String>("artistName")
    static let trackName =  Expression<String>("trackName")
    static let longDescription = Expression<String>("longDescription")
    static let previewUrl = Expression<String>("previewUrl")
    static let Kind = Expression<String>("Kind")
    
    static func createTable( ){
        let createTable = self.usersTable.create { (table) in
            table.column(self.artworkUrl100)
            table.column(self.artistName)
            table.column(self.trackName)
            table.column(self.longDescription)
            table.column(self.previewUrl)
            table.column(self.Kind)
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
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let dataBase = try Connection(fileUrl.path)
            self.database = dataBase
        }
        catch {
            print(error)
        }
    }
    
    
    
    static func insertTable(artistName: String, artworkUrl100: String, trackName: String,longDescription: String, previewUrl: String, kind: String) {
        let insertUser = self.usersTable.insert(self.artistName <- artistName, self.artworkUrl100 <- artworkUrl100 ,self.trackName <- trackName, self.longDescription <- longDescription , self.previewUrl <- previewUrl,self.Kind <- kind)
        do {
            try self.database.run(insertUser)
            try self.database.run(insertUser)
            print("INSERTED USER")
        } catch {
            print(error)
        }
    }
    
    static func returnDataSaved( )-> [MediaRsponse] {
        var mediaArr = [MediaRsponse]()
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("track: \(user[self.trackName]), name: \(user[self.artistName]), kind: \(user[self.Kind])")
                var media = MediaRsponse()
                media.trackName = user[self.trackName]
                media.artistName = user[self.artistName]
                media.Kind = user[self.Kind]
                media.previewUrl = user[self.previewUrl]
                media.artworkUrl100 = user[self.artworkUrl100]
                media.longDescription = user[self.longDescription]
                mediaArr.append(media)
            }
        } catch {
            print(error)
        }
        return mediaArr
    }
    
    static func deleteHistory( ){
        let table = self.usersTable
        let deleteHistory = table.delete()
        do {
            try self.database.run(deleteHistory)
        } catch {
            print(error)
        }
    }
}

