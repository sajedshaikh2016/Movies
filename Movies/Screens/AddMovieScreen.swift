//
//  AddMovieScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name: String = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhiteSpace && year != nil && !selectedActors.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $name)
            TextField("Year", value: $year, format: .number)
            
            Section("Select Actors") {
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    guard let year = year else { return }
                    let movie = Movie(name: name, year: year)
                    movie.actors = Array(selectedActors)
                    
                    selectedActors.forEach { actor in
                        actor.movies.append(movie)
                        modelContext.insert(actor)
                    }
                    
                    modelContext.insert(movie)
                    
                    do {
                        try modelContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}
