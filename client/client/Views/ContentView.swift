//
//  ContentView.swift
//  client
//
//  Created by Damian Diaz on 11/9/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: Int? = nil
    @State var grow = false
    
    @ObservedObject var store = FoodItemStore()
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                ZStack{
                    Circle()
                        .trim(from:0, to:1)
                        .stroke(Color.green, lineWidth: 60)
                        .frame(width:250)
                        .opacity(0.2)
                    Circle()
                        .trim(from: grow ? store.getAmountPercentage() : 1, to: 1)
                        .stroke(Color.green, lineWidth: 50)
                        .frame(width:250)
                        .rotationEffect(.degrees(-90), anchor: .center)
                        .animation(.easeOut(duration: 0.5))
                        .onAppear(){
                            self.grow.toggle()
                        }
                    .onDisappear(){
                        self.grow.toggle()
                    }
                    NavigationLink(destination: ItemView(store: store)){
                        VStack{
                            
                            Text(store.getAmount())
                                .fontWeight(.bold)
                                .frame(width: 250, height: 50, alignment: .center)
                                .font(.system(size: 60))
                                .foregroundColor(.secondary)
                        
                            Text("mg")
                                .fontWeight(.light)
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Divider()
                
                Text("Nov 17, 2019")
                    .fontWeight(.light)
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                
                
                
            }
                
                
            .navigationBarTitle(
                
                Text("Overview")
                
            )
        }
    }
    
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView(store: FoodItemStore(items: testData))
            //ContentView(selection: 0).environment(\.colorScheme, .dark)
        }
    }
}
#endif
