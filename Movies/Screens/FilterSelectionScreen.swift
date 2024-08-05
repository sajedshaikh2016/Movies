//
//  FilterSelectionScreen.swift
//  Movies
//
//  Created by Sajed Shaikh on 05/08/24.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    @Binding var filterOption: FilterOption
    
    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button("Search") {
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
