//
//  AttributionView.swift
//  QuickFlicks
//
//  Created by Brad B on 25/09/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct AttributionView: View {
    var body: some View {
        
        // TMDB attribution
        VStack(alignment: .center) {
            
            Text("Powered by:")
                .font(.footnote)
            Image("tmdb")
                .resizable()
                .frame(width: 150, height: 12)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct AttributionView_Previews: PreviewProvider {
    static var previews: some View {
        AttributionView()
    }
}
