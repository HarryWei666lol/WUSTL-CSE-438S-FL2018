//
//  DetailedViewController.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/
import UIKit

class DetailedViewController: UIViewController{
    var movie_image:UIImage!
    var date_release: String!
    var average_vote: Double!
    var movie_overview: String!
    var movie_title:String!
    var vote_count: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        // movie image background(a constant)
        let imageBackground = CGRect(x:0, y:60, width: view.frame.width, height:view.frame.height*0.4)
        let viewBackground = UIImageView(frame:imageBackground)
        view.addSubview(viewBackground)
        
        // movie image
        let movieImage_frame = CGRect(x: view.frame.width/4, y: 0, width:view.frame.width/2,height: viewBackground.frame.height)
        let viewImage = UIImageView(frame: movieImage_frame)
        viewImage.image = movie_image
        viewBackground.addSubview(viewImage)
        
        // movie title
        let movieTitle_frame = CGRect(x:0, y:view.frame.height*0.43 + 65, width: view.frame.width, height: 30)
        let viewTitle = UITextView(frame:movieTitle_frame)
        viewTitle.text = String("Title: "+movie_title)
        viewTitle.font = .systemFont(ofSize: 17)
        viewTitle.textAlignment = .left
        view.addSubview(viewTitle)
        
        // release date
        let release_frame = CGRect(x:0, y:view.frame.height*0.43+95, width: view.frame.width, height: 30)
        let viewRelease = UILabel(frame: release_frame)
        viewRelease.text = String("Release Date: "+date_release)
        viewRelease.font = .systemFont(ofSize: 17)
        viewRelease.textAlignment = .right
        view.addSubview(viewRelease)
        
        // vote average
        let vote_frame = CGRect(x:0, y: view.frame.height*0.43 + 125, width: view.frame.width, height: 30)
        let viewVote = UILabel(frame: vote_frame)
        viewVote.text = String("Vote Average: "+String(average_vote))
        viewVote.font = .systemFont(ofSize: 17)
        viewVote.textAlignment = .left
        view.addSubview(viewVote)

        // vote count
        let voteCount_frame = CGRect(x:0, y:view.frame.height*0.43 + 155, width: view.frame.width, height: 30)
        let viewVoteCount = UITextView(frame:voteCount_frame)
        viewVoteCount.text = String("Vote Count:"+String(vote_count))
        viewVoteCount.font = .systemFont(ofSize: 17)
        viewVoteCount.textAlignment = .right
        view.addSubview(viewVoteCount)
        
        // Overview
        let overview_frame = CGRect(x:0, y:view.frame.height*0.43 + 185, width: view.frame.width, height: 155)
        let viewText = UITextView(frame:overview_frame)
        viewText.text = String("Overview:"+movie_overview)
        viewText.font = .systemFont(ofSize: 17)
        viewText.textAlignment = .center
        view.addSubview(viewText)

        // Add to Favorites
        let button_frame = CGRect(x: view.frame.width/4, y: view.frame.height*0.43 + 340, width: view.frame.width/2,height:30)
        let favoriteButton = UIButton(frame: button_frame)
        favoriteButton.setTitle("Add To Favorites", for: .normal)
        favoriteButton.setTitleColor(UIColor.cyan, for: .normal)
        favoriteButton.layer.borderWidth = 2
        favoriteButton.layer.borderColor = UIColor.cyan.cgColor
        favoriteButton.addTarget(self, action: #selector(storeFavorite(_:)), for: .touchUpInside)
        view.addSubview(favoriteButton)
    }
    
    @objc private func storeFavorite(_ sender: UIButton?) {
        var storageArray = [String]()
        
        if (UserDefaults.standard.stringArray(forKey: "favoriteDatabase") == nil){
            storageArray.append(movie_title)
            UserDefaults.standard.set(storageArray, forKey: "favoriteDatabase")
        }
        else{
            storageArray = UserDefaults.standard.stringArray(forKey: "favoriteDatabase")!
            if(storageArray.contains(movie_title)){
            }
            else{
                storageArray.append(movie_title)
                
                UserDefaults.standard.set(storageArray, forKey: "favoriteDatabase")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
