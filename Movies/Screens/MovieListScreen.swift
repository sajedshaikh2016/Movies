//
//  MovieListScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Query(sort:\Movie.title, order: .forward) private var movies: [Movie]
    @State private var isAddMoviePresented: Bool = false
    
    var body: some View {
        MovieListView(movies: movies)
            .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Moview") {
                    isAddMoviePresented = true
                }
            }
        })
        .sheet(isPresented: $isAddMoviePresented, content: {
            NavigationStack {
                AddMovieScreen()
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self])
    }
}
