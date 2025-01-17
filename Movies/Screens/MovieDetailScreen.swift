//
//  MovieDetailScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct MovieDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let movie: Movie
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var showReviewScreen: Bool = false
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            Button("Update") {
                guard let year = year else { return }
                movie.name = title
                movie.year = year
                
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                dismiss()
            }.buttonStyle(.borderless)
            
            Section("Reviews") {
                Button(action: {
                    showReviewScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                
                if movie.reviews.isEmpty {
                    ContentUnavailableView {
                        Text("No reviews")
                    }
                } else {
                    ReviewListView(movie: movie)
                }
                
            }
            
            Section("Actors") {
                if movie.actors.isEmpty {
                    ContentUnavailableView {
                        Text("No actors available")
                    }
                } else {
                    List(movie.actors) { actor in
                        ActorCellView(actor: actor)
                    }
                }
            }
            
        }
        .onAppear(perform: {
            title = movie.name
            year = movie.year
        })
        .sheet(isPresented: $showReviewScreen, content: {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
        })
    }
}

struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        .onAppear(perform: {
            movie = Movie(name: "Antman", year: 2023)
            modelContext.insert(movie!)
        })
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self])
}
