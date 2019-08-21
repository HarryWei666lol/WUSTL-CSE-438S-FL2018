//
//  pet.swift
//  HarryWei-Lab2
//
//  Created by Harry Wei on 9/22/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//
import UIKit
import Foundation
class pet{
    //data
    var animal : String
    var color : UIColor
    var happyLevel : Int
    var foodLevel : Int
    var fullness : Double
    var size : Double
    
    //init
    init(petColor: UIColor, petAnimal: String, happinessLevel: Double, foodLevel: Double, fullness: Double, size : Double){
        self.color = petColor
        self.animal = petAnimal
        self.happyLevel = 0
        self.foodLevel = 0
        self.fullness = 0
        self.size = 20
    }
    
    //behavior
    func play() {
        if foodLevel > 0 {
            happyLevel = happyLevel + 1
            foodLevel = foodLevel - 1
        }
        print(happyLevel)
    }
    
    func feed() {
        foodLevel += 1
        print(foodLevel)
        fullToBurst()
    }
    
    func fullToBurst(){
        fullness = fullness + 1
    }
    
    func stomachburst() -> Bool {
        return fullness > size
    }
    
    func revival() {
        happyLevel = 0
        foodLevel = 0
        fullness = 0
        size = 20
    }
}
