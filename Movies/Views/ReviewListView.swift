//
//  ReviewListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 03/08/24.
//

import SwiftUI

struct ReviewListView: View {
    let reviews: [Review]
    
    var body: some View {
        List {
            ForEach(reviews) { review in
                VStack(alignment: .leading, content: {
                    Text(review.subject)
                    Text(review.body)
                })
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: [])
}
