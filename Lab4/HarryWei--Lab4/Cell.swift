//
//  Cell.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/

import Foundation
import UIKit
class Cell:UICollectionViewCell{
    var theImageView:UIImageView
    var theTitleLabel:UILabel
    
    override init(frame: CGRect) {
        //Inspired from http://randexdev.com/2014/07/uicollectionview/ and I made changes to the code online to suit the movie app
        theImageView = UIImageView(frame: CGRect(x:0,y:0,width:frame.size.width,height: frame.size.height))
        theTitleLabel = UILabel(frame: CGRect(x: 0, y: theImageView.frame.size.height * 0.87, width: frame.size.width, height: frame.size.height/7))
        theTitleLabel.textColor = UIColor.white
        theTitleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        super.init(frame: frame)
        contentView.addSubview(theImageView)
        theImageView.addSubview(theTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
