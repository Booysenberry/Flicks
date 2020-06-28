//
//  SearchView.swift
//  QuickFlicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBar(text: $searchText)
                
                List {
                    Text("Search Result")
                }
            }
            .navigationBarTitle("Search")
        }
    
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
