//
//  ActorDetailScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 04/08/24.
//

import SwiftUI

struct ActorDetailScreen: View {
    
    let actor: Actor
    @State private var selectedMovies: Set<Movie> = []
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(content: {
            MovieSelectionView(selectedMovies: $selectedMovies)
                .onAppear(perform: {
                    selectedMovies = Set(actor.movies)
                })
        })
        .onChange(of: selectedMovies, {
            actor.movies = Array(selectedMovies)
            modelContext.insert(actor)
        })
        .navigationTitle(actor.name)
    }
}

//#Preview {
//    ActorDetailScreen()
//}
