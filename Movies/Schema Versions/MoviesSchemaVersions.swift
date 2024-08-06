//
//  MoviesSchemaVersions.swift
//  Movies
//
//  Created by Sajed Shaikh on 06/08/24.
//

import Foundation
import SwiftData

enum MoviesSchemaV1: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        var title: String
        var year: Int
        
        @Transient var reviewsCount: Int {
            reviews.count
        }
        
        @Transient var actorsCount: Int {
            actors.count
        }
        
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
    
}


enum MoviesSchemaV2: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        @Attribute(.unique) var title: String
        var year: Int
        
        @Transient var reviewsCount: Int {
            reviews.count
        }
        
        @Transient var actorsCount: Int {
            actors.count
        }
        
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
    
}
