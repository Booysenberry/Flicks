//
//  FilmographyViewModel.swift
//  Flicks
//
//  Created by Brad B on 28/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class FilmographyViewModel: ObservableObject {
    
    @Published var fetchedRoles = [Movie]()
    
    func getRoles(actor: Int) {
        
        WebService().getRoles(actor: actor) { roles in
        
            if let roles = roles?.cast {

                for role in roles {
                    
                    self.fetchedRoles.append(role)
                }
            }
        }
    }
}
