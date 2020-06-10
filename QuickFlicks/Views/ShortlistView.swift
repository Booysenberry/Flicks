//
//  ShortlistView.swift
//  QuickFlicks
//
//  Created by Brad B on 10/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct ShortlistView: View {
    
    var body: some View {
        
        List(0 ..< 3) { movie in
            Image("sample")
                .resizable()
                .frame(width: 100, height: 150)
            
            NavigationLink (destination: DetailView()) {
                
                VStack(alignment: .leading) {
                    
                    Text("Title")
                        .font(.largeTitle)
                    
                }
            }
        }.navigationBarTitle("Shortlist")
    }
}

struct ShortlistView_Previews: PreviewProvider {
    static var previews: some View {
        ShortlistView()
    }
}
