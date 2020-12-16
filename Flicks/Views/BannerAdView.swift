//
//  BannerAdView.swift
//  Flicks
//
//  Created by Brad B on 16/12/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: View {
    var body: some View {
        
//        NavigationLink(destination: IAPView()) {
//            Text("Remove ads")
//        }
//        .font(.footnote)
//        .foregroundColor(.blue)
        
        
        // Banner ad
        GADBannerViewController()
            .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        
    }
}

struct BannerAdView_Previews: PreviewProvider {
    static var previews: some View {
        BannerAdView()
    }
}
