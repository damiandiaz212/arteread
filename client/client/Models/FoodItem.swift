//
//  FoodItem.swift
//  client
//
//  Created by Damian Diaz on 11/9/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import SwiftUI

struct FoodItem : Identifiable {
    
    var id = UUID()
    var name: String
    var amount: Int
    var timeStamp: String
    
}

#if DEBUG
let testData = [
    FoodItem(name: "Eggs", amount: 16, timeStamp: "at 9:48 AM"),
    FoodItem(name: "Pizza", amount: 8, timeStamp: "at 11:50 AM"),
    FoodItem(name: "Cheeseburger", amount: 23, timeStamp: "at 2:23 PM"),
    FoodItem(name: "Steak", amount: 45, timeStamp: "at 6:10 PM"),
    FoodItem(name: "Protein Shake", amount: 28, timeStamp: "at 8:05 PM")
]
#endif
