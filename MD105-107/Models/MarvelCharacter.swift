//
//  MarvelCharacter.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import Foundation
import SwiftData

struct MarvelCharacter: Identifiable {
    let id = UUID()
    var name: String
    var alias: String
    var description: String
    var imageName: String
    var rating: Int
    var review: String
    var isFavorite: Bool
}

@Model
class PersistentCharacter {
    var name: String
    var alias: String
    var characterDescription: String
    var imageName: String
    var rating: Int
    var review: String
    var isFavorite: Bool
    
    init(name: String, alias: String, characterDescription: String, imageName: String, rating: Int, review: String, isFavorite: Bool) {
        self.name = name
        self.alias = alias
        self.characterDescription = characterDescription
        self.imageName = imageName
        self.rating = rating
        self.review = review
        self.isFavorite = isFavorite
    }
}

extension MarvelCharacter {
    static let sample: [MarvelCharacter] = [
        .init(name: "Tony Stark", alias: "Iron Man",
              description: "Genius billionaire in powered armor.",
              imageName: "Iron_man", rating: 5,
              review: "Snarky, brilliant, always fun.", isFavorite: true),
        .init(name: "Steve Rogers", alias: "Captain America",
              description: "Super soldier and leader of the Avengers.",
              imageName: "captain america", rating: 5,
              review: "Always inspiring.", isFavorite: false),
        .init(name: "Natasha Romanoff", alias: "Black Widow",
              description: "Elite spy and assassin turned Avenger.",
              imageName: "Black widow", rating: 4,
              review: "Grounded and tactical.", isFavorite: false),
        .init(name: "Bruce Banner", alias: "Hulk",
              description: "Scientist whose anger unleashes the Hulk.",
              imageName: "hulk", rating: 3,
              review: "Raw power, big heart.", isFavorite: false),
        .init(name: "Thor Odinson", alias: "Thor",
              description: "God of Thunder from Asgard wielding Mjölnir.",
              imageName: "thor", rating: 5,
              review: "Mythic hero with humor.", isFavorite: true),
        .init(name: "Peter Parker", alias: "Spider-Man",
              description: "Friendly neighborhood hero with spider-powers.",
              imageName: "spiderman", rating: 5,
              review: "Heart + humor.", isFavorite: true),
        .init(name: "Stephen Strange", alias: "Doctor Strange",
              description: "Sorcerer Supreme guarding mystical realms.",
              imageName: "doctor strange", rating: 4,
              review: "Reality-bending visuals.", isFavorite: true),
    ]
}
