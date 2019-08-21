//
//  extensionScrollView.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/

import Foundation
import UIKit
//Inspired by https://stackoverflow.com/questions/307857/how-to-reset-the-scroll-position-of-a-uitableview

extension UIScrollView {
    /// Sets content offset to the top.
    func scrollBackTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
    func scrollBackBottom() {
        self.contentOffset = CGPoint(x: 25, y: 200)
    }
}
