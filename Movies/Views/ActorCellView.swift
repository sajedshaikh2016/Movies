//
//  ActorCellView.swift
//  Movies
//
//  Created by Sajed Shaikh on 04/08/24.
//

import SwiftUI

struct ActorCellView: View {
    
    let actor: Actor
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(actor.name)
            Text(actor.movies.map { $0.name}, format: .list(type: .and))
                .font(.caption)
        })
    }
}

//#Preview {
//    ActorCellView()
//}
