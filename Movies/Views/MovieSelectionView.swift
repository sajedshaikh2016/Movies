//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Sajed Shaikh on 04/08/24.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    
    @Query(sort: \Movie.name, order: .forward) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie>
    
    var body: some View {
        List(movies) { movie in
            HStack(content: {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.name)
            })
            
        }
    }
}

//#Preview {
//    MovieSelectionView()
//}
