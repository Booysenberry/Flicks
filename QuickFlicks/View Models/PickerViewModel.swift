//
//  PickerViewModel.swift
//  QuickFlicks
//
//  Created by Brad B on 24/08/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import Foundation

class PickerModel: ObservableObject {
    
    @Published var filter = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    let pickerOptions = ["Popular", "Top Rated"]
    
}
