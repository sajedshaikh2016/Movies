//
//  MovieListScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case showFilter
    
    var id: Int {
        hashValue
    }
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    @State private var actorName: String = ""
    @State private var activeSheet: Sheets?
    @State private var filterOption: FilterOption = .none
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        modelContext.insert(actor)
    }
    
    var body: some View {
        
        VStack(alignment: .leading, content: {
            HStack(alignment: .firstTextBaseline, content: {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter") {
                    activeSheet = .showFilter
                }
            })
            MovieListView(movies: movies)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        })
        
        .padding()
        
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    activeSheet = .addActor
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    activeSheet = .addMovie
                }
            }
        })
        
        
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addMovie:
                NavigationStack {
                    AddMovieScreen()
                }
            case .addActor:
                Text("Add Actor")
                    .font(.largeTitle)
                    .presentationDetents([.fraction(0.25)])
                TextField("Actor name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button("Save") {
                    saveActor()
                    self.activeSheet = nil
                }
            case .showFilter:
                FilterSelectionScreen(filterOption: $filterOption)
            case nil:
                Text("")
            }
        })
        
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}
