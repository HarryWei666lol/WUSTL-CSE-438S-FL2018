//
//  TableViewController.swift
//  HarryWei--Lab4
//
//  Created by Harry Wei on 10/21/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    // Inspired by https://www.andrewcbancroft.com/2015/02/12/custom-uitableviewcell-text-input-swift/
    @IBAction func addMovie(_ sender: Any) {
        let asking = UIAlertController(title:"Append Movie",message: "Have a good movie to add?", preferredStyle:.alert)
        asking.addTextField{
            (theMovie) in
            theMovie.placeholder = "Name of the movie to add"
        }
        let addition = UIAlertAction(title: "Add", style: .default){(_) in
            guard let newMovie = asking.textFields?.first?.text else{return}
            self.theFavorites.append(newMovie)
            UserDefaults.standard.set(self.theFavorites,forKey: "myFavorites")
        }
        asking.addAction(addition)
        present(asking,animated:false)
    }
    
    @IBOutlet weak var theTableView: UITableView!
    
    var theFavorites = [String](){
        didSet{
            theTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(UserDefaults.standard.stringArray(forKey: "favoriteDatabase") != nil){
            theFavorites = UserDefaults.standard.stringArray(forKey: "favoriteDatabase")!
        }
    }
    
    func tableView(_ theTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theFavorites.count
    }
    
    func tableView(_ theTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier:"cell")
        cell.textLabel?.text = theFavorites[indexPath.row]
        return cell
    }
    
    //Inspired from https://stackoverflow.com/questions/32004557/swipe-able-table-view-cell-in-ios-9
    func tableView(_ theTableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Delete
        let delete = UIContextualAction(style: .destructive, title:  "Delete it", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            theTableView.beginUpdates()
            self.theFavorites.remove(at: indexPath.row)
            UserDefaults.standard.set(self.theFavorites, forKey: "favoriteDatabase")
            theTableView.deleteRows(at: [indexPath], with: .automatic)
            theTableView.endUpdates()
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        theTableView.dataSource = self
        theTableView.delegate = self
    theTableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}
