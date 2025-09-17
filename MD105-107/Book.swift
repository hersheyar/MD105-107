//
//  Book.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var author: String
    var image: String
    var description: String
    var rating: Int
    var review: String
}
