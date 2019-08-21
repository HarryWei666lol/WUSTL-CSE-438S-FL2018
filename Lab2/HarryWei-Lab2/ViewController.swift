//
//  ViewController.swift
//  HarryWei-Lab2
//
//  Created by Harry Wei on 9/22/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var currentPet:pet!
    var bird = pet(petColor: UIColor.red, petAnimal: "Bird", happinessLevel: 0, foodLevel: 0, fullness: 0, size : 20)
    var bunny = pet(petColor: UIColor.blue, petAnimal: "Bunny", happinessLevel: 0, foodLevel: 0, fullness: 0, size : 20)
    var cat = pet(petColor: UIColor.green, petAnimal: "Cat", happinessLevel: 0, foodLevel: 0, fullness: 0, size : 20)
    var dog = pet(petColor: UIColor.yellow, petAnimal: "Dog", happinessLevel: 0, foodLevel: 0, fullness: 0, size : 20)
    var fish = pet(petColor: UIColor.black, petAnimal: "fish", happinessLevel: 0, foodLevel: 0, fullness: 0, size : 20);

    var audioBird = AVAudioPlayer()
    var audioCat = AVAudioPlayer()
    var audioFish = AVAudioPlayer()
    var audioBunny = AVAudioPlayer()
    var audioDog = AVAudioPlayer()

    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var foodLevelDisplayView: DisplayView!
    @IBOutlet weak var foodLevel: UILabel!
    
    @IBOutlet weak var background: DisplayView!
    
    @IBAction func birdChosen(_ sender: Any) {
        petImage.image = UIImage(named:"Bird");
        background.backgroundColor = UIColor.red
        currentPet = bird
        updateFoodLevel()
        updateHappyLevel()
        status.text = ""
        foodLevelDisplayView.color = UIColor.red
        happinessLevelDisplayView.color = UIColor.red
        let birdPath = Bundle.main.path(forResource: "windy", ofType: "wav")
        print("PATH")
        print(birdPath!)
        let birdURL = NSURL.fileURL(withPath: birdPath!)
        print("URL")
        print(birdURL.absoluteString)
        do{
            audioBird = try AVAudioPlayer(contentsOf: birdURL)
            audioBird.play()
            
        } catch{print(error)}
        
    }
    @IBAction func fishChosen(_ sender: Any) {
        petImage.image = UIImage(named:"Fish");
        background.backgroundColor = UIColor.red
        currentPet = fish
        updateFoodLevel()
        updateHappyLevel()
        status.text = ""
        foodLevelDisplayView.color = UIColor.red
        happinessLevelDisplayView.color = UIColor.red
        let birdPath = Bundle.main.path(forResource: "water", ofType: "wav")
        print("PATH")
        print(birdPath!)
        let birdURL = NSURL.fileURL(withPath: birdPath!)
        print("URL")
        print(birdURL.absoluteString)
        do{
            audioBird = try AVAudioPlayer(contentsOf: birdURL)
            audioBird.play()
            
        } catch{print(error)}
    }
    @IBAction func dogChosen(_ sender: Any) {
        petImage.image = UIImage(named:"Dog");
         background.backgroundColor = UIColor.yellow
        currentPet = dog
        updateFoodLevel()
        updateHappyLevel()
        status.text = ""
        foodLevelDisplayView.color = UIColor.yellow
        happinessLevelDisplayView.color = UIColor.yellow
        let birdPath = Bundle.main.path(forResource: "dog", ofType: "wav")
        print("PATH")
        print(birdPath!)
        let birdURL = NSURL.fileURL(withPath: birdPath!)
        print("URL")
        print(birdURL.absoluteString)
        do{
            audioBird = try AVAudioPlayer(contentsOf: birdURL)
            audioBird.play()
            
        } catch{print(error)}
    }
    
    @IBAction func catChosen(_ sender: Any) {
        petImage.image = UIImage(named:"Cat");
         background.backgroundColor = UIColor.green
        currentPet = cat
        updateFoodLevel()
        updateHappyLevel()
        status.text = ""
        foodLevelDisplayView.color = UIColor.green
        happinessLevelDisplayView.color = UIColor.green
        let birdPath = Bundle.main.path(forResource: "cat", ofType: "wav")
        print("PATH")
        print(birdPath!)
        let birdURL = NSURL.fileURL(withPath: birdPath!)
        print("URL")
        print(birdURL.absoluteString)
        do{
            audioBird = try AVAudioPlayer(contentsOf: birdURL)
            audioBird.play()
            
        } catch{print(error)}
    }
    @IBAction func bunnyChosen(_ sender: Any) {
        petImage.image = UIImage(named:"Bunny");
         background.backgroundColor = UIColor.blue
        currentPet = bunny
        updateFoodLevel()
        updateHappyLevel()
        status.text = ""
        foodLevelDisplayView.color = UIColor.blue
        happinessLevelDisplayView.color = UIColor.blue
//        let birdPath = Bundle.main.path(forResource: "grass", ofType: "wav")
//        let birdURL = NSURL.fileURL(withPath: birdPath!)
//        print(birdURL.absoluteString)
//        do{
//            audioBird = try AVAudioPlayer(contentsOf: birdURL)
//            audioBird.play()
//
//        } catch{print(error)}
    }
    
    @IBOutlet weak var happinessLevelDisplayView: DisplayView!
    @IBOutlet weak var happinessLevel: UILabel!

    
    @IBAction func toBeRevived(_ sender: Any) {
        currentPet.revival()
        updateFoodLevel()
        updateHappyLevel()
        status.text = "Your pet is revived!"
        
        
    }
    @IBAction func toBeFed(_ sender: Any) {

        if(currentPet.foodLevel == 20){
            status.text = "Dead Pet due to overeating :<"
        }
            
        else if(currentPet.foodLevel < 18){
            status.text = "Your pet is alive and jumping!"
            currentPet.feed()
            updateFoodLevel()
        }
        else if(currentPet.foodLevel >= 18 ){
            status.text = "Do CPR, it is dying:("
            currentPet.feed()
            updateFoodLevel()
        }
        
    }
    @IBAction func toBePlayed(_ sender: Any) {
        if(currentPet.foodLevel != 20){
            currentPet.play()
            updateHappyLevel()
            if(currentPet.happyLevel < 5){
                status.text = "Your pet is bored"
            }
            else if (currentPet.happyLevel < 10){
                status.text = "Your pet is getting excited"
            }
            else if(currentPet.happyLevel < 15){
                status.text = "Your pet is running wild"
            }
            else{
                status.text = "More, play with me more"
            }
        }
    }
    
    func updateHappyLevel(){
        var happylevel = Double(currentPet.happyLevel) / 20
        happinessLevelDisplayView.animateValue(to: CGFloat(happylevel))
        happylevel *= 20
        happinessLevel.text = String(currentPet.happyLevel)
        updateFoodLevel()
    }
    
    func updateFoodLevel(){
        
        var foodlevel = Double(currentPet.foodLevel)/20
       foodLevelDisplayView.animateValue(to: CGFloat(foodlevel))
        foodlevel = foodlevel * 20
        //print("test",foodLevel.text)
        foodLevel.text = String(foodlevel)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentPet = bird;
        background.backgroundColor = UIColor.red
        foodLevelDisplayView.color = UIColor.red
        happinessLevelDisplayView.color = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLevelValues(pet: pet) {
        happinessLevel.text = String(currentPet.happyLevel)
        foodLevel.text = String(pet.foodLevel)
        happinessLevelDisplayView.animateValue(to: CGFloat(currentPet.happyLevel))
        foodLevelDisplayView.animateValue(to: CGFloat(pet.foodLevel))
    }


}

