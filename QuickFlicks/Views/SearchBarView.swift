//
//  SearchBar.swift
//  QuickFlicks
//
//  Created by Brad B on 29/06/20.
//  Copyright © 2020 Brad B. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    
    var searchVM: SearchViewModel
    
    @Binding var text: String
    
    @State private var isEditing = false
    
     var body: some View {
        
            HStack {
     
                TextField("Search for a movie", text: $text,
                          onCommit: {
                            self.searchVM.searchedMovies.removeAll()
                            self.searchVM.currentPage = 1
                            self.searchVM.fetchMovies(movie: self.text)
                })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                    
                    // Add search icon and cross icon
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
     
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     
                    }) {
                        Text("Cancel")
                        
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
    }

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView(text: .constant(""))
//    }
//}
