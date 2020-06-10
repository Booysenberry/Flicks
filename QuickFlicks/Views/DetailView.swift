//
//  DetailView.swift
//  QuickFlicks
//
//  Created by Brad B on 11/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    var body: some View {
        
        VStack {
            
            MovieDetailsView()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent accumsan libero nec commodo ultricies. Vestibulum quam mi, ultricies ac sem non, accumsan dapibus eros. Vivamus suscipit tellus ligula, at semper nulla iaculis eu. Fusce ac libero eget nisi consequat dictum et sit amet mauris. Nullam vel dignissim tortor. Curabitur tristique, sapien ut lobortis aliquet, sapien turpis blandit elit, at placerat nibh risus quis dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam rutrum porttitor orci, quis rhoncus felis gravida vel. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras tempus nibh eget neque sodales mattis. Etiam eget quam ex.")
            
            Spacer()
            
        }.navigationBarTitle("Movie Details")
            .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct RatingView: View {
    var body: some View {
        
        VStack {
            HStack {
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text("60%")
            }
            HStack {
                
                Image(systemName: "person.3.fill")
                
                Text("99")
            }
        }
    }
}

struct MovieDetailsView: View {
    var body: some View {
        HStack {
            
            Image("sample")
                .resizable()
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                
                Text("Title")
                    .font(.largeTitle)
                
                Text("Released: 2019-11-21")
                RatingView()
                
            }
            Spacer()
        }
    }
}
