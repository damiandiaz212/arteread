//
//  FoodItemStore.swift
//  client
//
//  Created by Damian Diaz on 11/9/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import SwiftUI
import Combine

class FoodItemStore : ObservableObject {
    
    var items: [FoodItem] {
        didSet { objectWillChange.send() }
    }

    
    init(items: [FoodItem] = []){
        self.items = items
    }
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    func getAmount() -> String{
       
        var t = 0
        
        for i in items{
            t+=i.amount
        }
        
        return String(t)
    }
    
    func getAmountPercentage() -> CGFloat{
        
        var t:CGFloat  = 0
        
        for i in items{
            t+=CGFloat(i.amount)
        }
        
        t = CGFloat(1) - (t / CGFloat(300))
        
        return t
    }
    
}
