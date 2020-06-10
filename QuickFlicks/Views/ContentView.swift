//
//  ContentView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let genres = ["Action", "Comedy", "Western", "Drama"]
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(genres, id:\.self) { genre  in
                    
                    NavigationLink (destination: ShortlistView()) {
                        
                        Text(genre)
                    }
                }
                
            }.navigationBarTitle("Choose Genre")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
