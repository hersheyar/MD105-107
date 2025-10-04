//
//  MD105_107Tests.swift
//  MD105-107Tests
//
//  Created by Andrew Hershey on 9/11/25.
//

import Testing
@testable import MD105_107

struct MarvelCharacterTests {
    @Test func testCharacterInitialization() {
        let hero = MarvelCharacter(
            name: "Tony Stark",
            alias: "Iron Man",
            description: "Genius billionaire in powered armor.",
            imageName: "ironman",
            rating: 5,
            review: "Smart and confident.",
            isFavorite: true
        )
        
        #expect(hero.name == "Tony Stark")
        #expect(hero.alias == "Iron Man")
        #expect(hero.rating == 5)
        #expect(hero.isFavorite)
    }
    
    @Test func testToggleFavoriteStatus() {
        var hero = MarvelCharacter.sample[0]
        let originalFavorite = hero.isFavorite
        hero.isFavorite.toggle()
        #expect(hero.isFavorite != originalFavorite)
    }
    
    @Test func testSampleCharactersLoaded() {
        #expect(MarvelCharacter.sample.count > 0)
        #expect(MarvelCharacter.sample.first?.alias == "Iron Man")
    }
}

struct PersistentCharacterTests {
    @Test func testPersistentCharacterInitialization() {
        let persistent = PersistentCharacter(
            name: "Steve Rogers",
            alias: "Captain America",
            characterDescription: "Super soldier and leader of the Avengers.",
            imageName: "captain america",
            rating: 5,
            review: "Always inspiring.",
            isFavorite: false
        )
        
        #expect(persistent.alias == "Captain America")
        #expect(persistent.rating == 5)
        #expect(persistent.isFavorite == false)
    }
}
