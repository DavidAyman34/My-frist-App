//
//  myMovies.swift
//  MoviesApp
//
//  Created by Divo Ayman on 3/24/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit
struct MyMovies: Decodable {
    var title: String!
    var image: String!
    var rating: Double!
    var releaseYear: Int!
}

