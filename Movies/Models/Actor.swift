//
//  Achtor.swift
//  Movies
//
//  Created by Sajed Shaikh on 04/08/24.
//

import Foundation
import SwiftData

@Model
final class Actor {
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
