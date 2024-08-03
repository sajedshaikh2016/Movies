//
//  MovieListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    let movies: [Movie]
    @Environment(\.modelContext) private var modelcontext
    
    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            modelcontext.delete(movie)
            
            do {
                try modelcontext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    HStack {
                        Text(movie.title)
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }.onDelete(perform: { indexSet in
                deleteMovie(indexSet: indexSet)
            })
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailScreen(movie: movie)
        }
    }
}

#Preview {
    MovieListView(movies: [])
        .modelContainer(for: [Movie.self])
}
