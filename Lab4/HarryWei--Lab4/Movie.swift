//
//  Movie.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/

import Foundation
import UIKit
struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
}
