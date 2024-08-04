//
//  ActorListView.swift
//  Movies
//
//  Created by Sajed Shaikh on 04/08/24.
//

import SwiftUI

struct ActorListView: View {
    
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            Text(actor.name)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
