//
//  Media.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/30/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation

struct MediaRsponse: Codable {
    
    var artworkUrl100 : String!
    var  artistName : String?
    var  trackName : String?
    var longDescription : String?
    var previewUrl: String!
    var Kind : String?
    init() {
        
    }
    func getType() -> mediaType {
        switch self.Kind {
        case "movie" :
            return  mediaType.movie
        case "music" :
            return mediaType.music
        case "tvShow" :
            return mediaType.tvShow
        default :
            return mediaType.music
        }
    }
    
}

