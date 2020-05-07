//
//  ResponseMedia.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/30/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation
public enum mediaType:String,Codable{
    case movie = "movie"
    case tvShow = "tvShow"
    case music = "music"
}
struct MediaData:Codable {
    var resultCount: Int
    var results : [MediaRsponse]
}
