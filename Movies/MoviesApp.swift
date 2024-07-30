//
//  MoviesApp.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }.modelContainer(for: [Movie.self])
    }
}
