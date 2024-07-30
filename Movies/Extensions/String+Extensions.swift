//
//  String+Extensions.swift
//  Movies
//
//  Created by Sajed Shaikh on 30/07/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
