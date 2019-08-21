//
//  ViewController.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//  All movie data is from The Movie Database API https://developers.themoviedb.org/4/


import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDataSource, UISearchBarDelegate,UICollectionViewDelegate  {

    @IBOutlet weak var querySearchBar: UISearchBar!
    
    @IBAction func scrollBackTop(_ sender: Any) {
        self.CollectionView.scrollBackTop()
    }
    
    @IBAction func scrollToBottum(_ sender: Any) {
        self.CollectionView.scrollBackBottom()
    }
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var movies = [Movie]()
    var imageCache:[UIImage] = []
    var currentQuery = ""
    var num_prevMovies:Int = 0
    var pageNum:Int = 1
    var theActivityIndicator = UIActivityIndicatorView()
    
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.theActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.theActivityIndicator.frame = CGRect(x: view.frame.size.width/2-20, y: view.frame.size.height/2, width: 46, height: 46)
        self.theActivityIndicator.hidesWhenStopped = true
        view.addSubview(self.theActivityIndicator)
        
        //set up CollectionView
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.register(Cell.self, forCellWithReuseIdentifier: "myCell")
        
        //searchBar delegate
        querySearchBar.delegate = self
        
        // audio
        let moviePath = Bundle.main.path(forResource: "movieAudio", ofType: "mov")
        let playmovie = NSURL.fileURL(withPath: moviePath!)
        
        do{
            audio = try AVAudioPlayer(contentsOf: playmovie)
            audio.setVolume(70, fadeDuration: 10)
            audio.play()
            
        } catch{print(error)}
    }
    //number of cells in collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    //image and title for each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! Cell
        theCell.theTitleLabel.text = movies[indexPath.row].title
        theCell.theImageView.image = imageCache[indexPath.row]
        return theCell
    }
    //pushes a new viewControler for each cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        let theDetailedVC = DetailedViewController()
        theDetailedVC.movie_image = imageCache[indexPath.row]
        theDetailedVC.date_release = movies[indexPath.row].release_date
        theDetailedVC.average_vote = movies[indexPath.row].vote_average
        theDetailedVC.vote_count = movies[indexPath.row].vote_count
        theDetailedVC.movie_overview = movies[indexPath.row].overview
        theDetailedVC.movie_title = movies[indexPath.row].title
    navigationController?.pushViewController(theDetailedVC, animated: true)
    }
    //after each search, update collectionView
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pageNum = 1
        self.theActivityIndicator.startAnimating()
        currentQuery = searchBar.text!
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async{
            self.fetchingJSONData(string: self.currentQuery)
            self.fetchingImages()
            self.num_prevMovies = self.movies.count
            DispatchQueue.main.async(){
                self.CollectionView.reloadData()
                self.theActivityIndicator.stopAnimating()
            }
        }
    }
    //fetch once when at the bottom but continues to scroll
    //from video, changed
    func beginBatchFetch(){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async{
            DispatchQueue.main.async(){
                self.CollectionView.reloadData()
            }
        }
    }
    
    func fetchingJSONData(string:String){
        movies = []
        let apiKey = "8fcb125df8ab0b12da7b67370d57e465"
        var movieName = string
        if(movieName != ""){
            movieName = movieName.replacingOccurrences(of: " ", with: "%20")
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key="+apiKey+"&query="+movieName)
            let data = try? Data(contentsOf: url!)
            let apiResults = try! JSONDecoder().decode(APIResults.self, from: data!)
            let movieInfo = apiResults.results
            let movieNum = movieInfo.count
            if (movieNum != 0){
                for movie in movieInfo{
                        let movieTitle = movie.title
                        let movieID = movie.id
                        let moviePosterPath = movie.poster_path
                        let movieReleaseDate = movie.release_date
                        let movieVoteAverage = movie.vote_average
                        let movieOverview = movie.overview
                        let movieVoteCount = movie.vote_count
                        movies.append(Movie(id: movieID, poster_path: moviePosterPath, title: movieTitle, release_date: movieReleaseDate, vote_average: movieVoteAverage, overview: movieOverview, vote_count: movieVoteCount))
                }
            }
        }
    }
    
    func fetchingImages(){
        imageCache = []
        let baseUrl = "https://image.tmdb.org/t/p/"
        let theSize = "w185"
        for item in movies{
            if item.poster_path != nil{
                let theUrl = URL(string: baseUrl+theSize+"/"+item.poster_path!)
                let theData = try? Data(contentsOf:theUrl!)
                let theImage = UIImage(data: theData!)
                imageCache.append(theImage!)
            }
            else{
                imageCache.append(#imageLiteral(resourceName: "noImage.001"))
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

