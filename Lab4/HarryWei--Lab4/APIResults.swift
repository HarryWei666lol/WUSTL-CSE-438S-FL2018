//
//  APIResults.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/

import Foundation
struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
