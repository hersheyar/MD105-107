//
//  PersistentCharacter.swift
//  MD105-107
//
//  Created by Andrew Hershey on 10/4/25.
//

import SwiftData

@Model
class PersistentCharacter {
    var name: String
    var alias: String
    var characterDescription: String
    var imageName: String
    var rating: Int
    var review: String
    var isFavorite: Bool
    
    init(
        name: String,
        alias: String,
        characterDescription: String,
        imageName: String,
        rating: Int,
        review: String,
        isFavorite: Bool
    ) {
        self.name = name
        self.alias = alias
        self.characterDescription = characterDescription
        self.imageName = imageName
        self.rating = rating
        self.review = review
        self.isFavorite = isFavorite
    }
}
