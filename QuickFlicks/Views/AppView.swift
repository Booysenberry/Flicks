//
//  AppView.swift
//  QuickFlicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        
        
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Genres")
            }
            
            SearchView() 
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
        }
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
