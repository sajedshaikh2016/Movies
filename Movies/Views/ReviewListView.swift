//
//  ReviewListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 03/08/24.
//

import SwiftUI

struct ReviewListView: View {
    
    let movie: Movie
    @Environment(\.modelContext) private var modelContext
    
    /// Delete a review
    /// - Parameter indexSet: location id for a review
    private func deleteReview(indexSet: IndexSet) {
        indexSet.forEach { index in
            let review = movie.reviews[index]
            modelContext.delete(review)
            
            do {
                movie.reviews.remove(at: index)
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    var body: some View {
        List {
            ForEach(movie.reviews) { review in
                VStack(alignment: .leading, content: {
                    Text(review.subject)
                    Text(review.body)
                })
            }.onDelete(perform: { indexSet in
                deleteReview(indexSet: indexSet)
            })
        }
    }
}

//#Preview {
//    ReviewListView(reviews: [])
//        .modelContainer(for: [Review.self, Movie.self])
//}
