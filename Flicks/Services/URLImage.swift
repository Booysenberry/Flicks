//
//  URLImage.swift
//  Flicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, type: String, placeholder: Image = Image("noImageFound")) {
        
        switch type {
        case "coverArt":
            self.placeholder = Image("noImageFound").resizable()
        case "cast":
            self.placeholder = Image("noProfileImageFound").resizable()
        default:
            self.placeholder = Image("noImageFound").resizable()
        }
    
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage)
            .resizable()
 
        } else {
            return placeholder
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


