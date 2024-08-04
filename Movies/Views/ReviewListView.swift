//
//  ReviewListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 03/08/24.
//

import SwiftUI

struct ReviewListView: View {
    
    let reviews: [Review]
    @Environment(\.modelContext) private var modelContext
    
    private func deleteReview(indexSet: IndexSet) {
        indexSet.forEach { index in
            let review = reviews[index]
            modelContext.delete(review)
            
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    var body: some View {
        List {
            ForEach(reviews) { review in
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

#Preview {
    ReviewListView(reviews: [])
        .modelContainer(for: [Review.self, Movie.self])
}
