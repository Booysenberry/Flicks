//
//  TVShowDetailView.swift
//  Flicks
//
//  Created by Brad B on 22/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct TVShowDetailView: View {
    
    @ObservedObject private var TVDetailVM = TVDetailViewModel()
    
    // Core data
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var show: Show
    
    @State private var showingAlert = false
    
    init(show: Show) {
        self.show = show
        TVDetailVM.getCast(show: show.id)
        
        // Stop Scrollview bounce
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        VStack {
            
            TVHeroImage(show: show)
        }
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
            
            // Synopsis
            Text(show.overview)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            
            ScrollView(.horizontal) {
                
                CastView(cast: TVDetailVM.castMembers)
                    .buttonStyle(PlainButtonStyle())
                
            }
            
            // TMDB attribution
            AttributionView()
            
            }.padding()
                
        }
        // Banner ad
        VStack {
            Button(action: {
                // your action here
            }) {
                Text("Remove ads")
            }.font(.footnote)
            .foregroundColor(.blue)
            
            GADBannerViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        }
        
        
            
        .navigationBarTitle(show.name)
        
        .navigationBarItems(trailing:
                                Button(action: {
                                    
                                    // Save to core data
                                    let showToBeSaved = SavedShow(context: self.managedObjectContext)
                                    showToBeSaved.name = self.show.name
                                    showToBeSaved.id = Int32(self.show.id)
                                    showToBeSaved.backdropPath = self.show.backdropPath
                                    showToBeSaved.popularity = self.show.popularity
                                    showToBeSaved.posterPath = self.show.posterPath
                                    showToBeSaved.overview = self.show.overview
                                    showToBeSaved.voteAverage = self.show.voteAverage
                                    showToBeSaved.voteCount = Int32(self.show.voteCount)
                                    
                                    self.showingAlert = true
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        // handle the Core Data error
                                    }
                                    
                                }) {
                                    Image(systemName: "bookmark")
                                        .foregroundColor(.white)
                                    
                                }.alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Saved"), message: Text("Show added to watch list"), dismissButton: .default(Text("Got it!")))
                                })
    }
}


//struct TVShowDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TVShowDetailView()
//    }
//}


