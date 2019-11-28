//
//  ItemAdd.swift
//  client
//
//  Created by Damian Diaz on 11/10/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import SwiftUI



struct ItemAdd: View {
    
    @State private var searchString: String = ""
    @State private var displayString: String = " "
    @State private var didSearch: Bool = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 50) {
                
                Spacer()
            
                VStack  {
                    
                    TextField("\"pizza\", \"donut\", etc", text: $searchString)
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
//                    Button("Search"){
//                        self.displayString = self.searchString
//                        self.updateSearch()
//                    }
//                    .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.green, lineWidth: 1)
//                        
//                    )
//                    .foregroundColor(.green)
                    
                }
                
                List {
                    
                    Text("Result 1")
                    Text("Result 2")
                    
                }
                
                if(didSearch){
                    Text("2 results for \(displayString) found")
                }
                
            }
        
        }
       
        
    }
    
    func updateSearch(){
        didSearch = true
    }
}


#if DEBUG
struct ItemAdd_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            //Items(store: FoodItemStore(items: testData)).environment(\.colorScheme, .dark)
            ItemAdd()
            //ItemAdd().environment(\.colorScheme, .dark)
        }
    }
}
#endif
