//
//  ImageLoader.swift
//  QuickFlicks
//
//  Created by Brad B on 13/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var downloadedImage: UIImage?
    
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    // PassthroughSubject = ability to call 'send' and push new values downstream
    
    func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                     self.didChange.send(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
        
                self.downloadedImage = UIImage(data: data)
                self.didChange.send(self)
            }
            
        }.resume()
    }
}

