//
//  MovieListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct MovieListView: View {
    
    @Query private var movies: [Movie]
    let filterOption: FilterOption
    
    init(filterOption: FilterOption = .none) {
        self.filterOption = filterOption
        
        switch self.filterOption {
            case .title(let movieTitle):
                _movies = Query(filter: #Predicate<Movie> { movie in
                movie.title.contains(movieTitle)
            })
            case .none:
                _movies = Query()
            }
    }
    
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
                    HStack(alignment: .firstTextBaseline, content: {
                        VStack(alignment: .leading, content: {
                            Text(movie.title)
                            Text("Number of reviews: \(movie.reviewsCount)")
                                .font(.caption)
                            Text("Number of actors: \(movie.actorsCount)")
                                .font(.caption)
                        })
                        Spacer()
                        Text(movie.year.description)
                    })
                 
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
    MovieListView(filterOption: .none)
        .modelContainer(for: [Movie.self])
}
