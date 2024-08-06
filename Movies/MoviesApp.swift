//
//  MoviesApp.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

@main
struct MoviesApp: App {
    
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(
                for: Movie.self,
                migrationPlan: MoviesMigrationPlan.self,
                configurations: ModelConfiguration(for: Movie.self)
            )
        } catch {
            fatalError("Could not intialise the container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }.modelContainer(container)
    }
}
