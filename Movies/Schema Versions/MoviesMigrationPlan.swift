//
//  MoviesMigrationPlan.swift
//  Movies
//
//  Created by Sajed Shaikh on 06/08/24.
//

import Foundation
import SwiftData

enum MoviesMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type] {
        [MoviesSchemaV1.self, MoviesSchemaV2.self, MoviesSchemaV3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2, migrateV2toV3]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: MoviesSchemaV1.self, toVersion: MoviesSchemaV2.self, willMigrate: { context in
            guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else { return }
            var duplicates = Set<Movie>()
            var uniqueSet = Set<String>()
            
            for movie in movies {
                if !uniqueSet.insert(movie.name).inserted {
                    duplicates.insert(movie)
                }
            }
            
            for movie in duplicates {
                guard let moviesToBeUpdated = movies.first(where: { $0.id == movie.id }) else { continue }
                moviesToBeUpdated.name = moviesToBeUpdated.name + " \(UUID().uuidString)"
            }
            
            try? context.save()
            
        }, didMigrate: nil)
 
    
    static let migrateV2toV3 = MigrationStage.lightweight(fromVersion: MoviesSchemaV2.self, toVersion: MoviesSchemaV3.self)
    
}
