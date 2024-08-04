//
//  MovieListScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort:\Movie.title, order: .forward) private var movies: [Movie]
    @State private var isAddMoviePresented: Bool = false
    @State private var isActorPresented: Bool = false
    @State private var actorName: String = ""
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        modelContext.insert(actor)
    }
    
    var body: some View {
        MovieListView(movies: movies)
            .toolbar(content: {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add Actor") {
                        isActorPresented = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Movie") {
                        isAddMoviePresented = true
                    }
                }
                
        })
        .sheet(isPresented: $isAddMoviePresented, content: {
            NavigationStack {
                AddMovieScreen()
            }
        })
        .sheet(isPresented: $isActorPresented, content: {
            Text("Add Actor")
                .font(.largeTitle)
                .presentationDetents([.fraction(0.25)])
            TextField("Actor name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Save") {
                saveActor()
                isActorPresented = false
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
