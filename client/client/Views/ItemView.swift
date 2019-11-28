//
//  ItemView.swift
//  client
//
//  Created by Damian Diaz on 11/10/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import SwiftUI

struct Result {
  let name: String
  let amount: Int
}


struct ItemView: View {
    
    @ObservedObject var store = FoodItemStore()
    
    var body: some View {
        
        NavigationView{
        
                
                List {
                    
                    Section{
                        Button("Add item"){
                            
                        }
                    }
                    
                    Section{
                        ForEach(store.items) { item in
                            ItemCell(item: item)
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                    
                }.listStyle(GroupedListStyle())
            
            
        }
            
        .navigationBarTitle("So far")
    
    }
    
    
    func delete(at offsets: IndexSet){
        store.items.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int){
        store.items.move(fromOffsets: source, toOffset: destination)
    }
    
}


struct ItemCell: View {
    
    let item: FoodItem
    
    var body: some View {
        
        
        HStack{
            VStack(alignment: .leading){
                Text(item.name)
                Text(item.timeStamp).font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(String(item.amount)+" mg").font(.headline).foregroundColor(.secondary)
            }
        }
        
    }
}

#if DEBUG
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ItemView(store: FoodItemStore(items: testData))
            //ItemView()
            //ItemView().environment(\.colorScheme, .dark)
        }
    }
}
#endif
