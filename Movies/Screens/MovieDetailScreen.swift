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
    @Environment(\.modelContext) private var context
    let movie: Movie
    
    @State private var title: String = ""
    @State private var year: Int?
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            Button("Update") {
                guard let year = year else { return }
                movie.title = title
                movie.year = year
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                dismiss()
            }.buttonStyle(.borderless)
        }
        .onAppear(perform: {
            title = movie.title
            year = movie.year
        })
    }
}

struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        .onAppear(perform: {
            movie = Movie(title: "Antman", year: 2023)
            context.insert(movie!)
        })
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self])
}
