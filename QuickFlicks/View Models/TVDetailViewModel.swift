//
//  TVDetailViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 23/07/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class TVDetailViewModel: ObservableObject {
    
    @Published var castMembers = [Cast]()
    
    private var fetchedCast = [ShowCast]()
    
    func getCast(show: Int) {
        
        WebService().getTVCast(show: show) { cast in
            
            if let cast = cast?.cast {
                
                self.castMembers.append(contentsOf: cast)
            }
        }
    }
}

