//
//  Easy.swift
//  Monkey Quiz
//
//  Created by Quinn Morgan on 17/03/2022.
//

import Foundation
import SwiftUI

struct Monkey: Identifiable {
    let id = UUID()
    let name : String
    let imageName : String
}

let easy = [
    Monkey(name: "Baboon", imageName: "baboon"),
    Monkey(name: "Capuchin", imageName: "capuchin"),
    Monkey(name: "Gorilla", imageName: "gorilla"),
    Monkey(name: "Howler Monkey", imageName: "howler"),
    Monkey(name: "Lemur", imageName: "lemur"),
    Monkey(name: "Orangutan", imageName: "orangutan"),
    Monkey(name: "Spider Monkey", imageName: "spider"),
    Monkey(name: "Squirrel Monkey", imageName: "squirrel")
    ]

let medium = [
    Monkey(name: "Aye Aye", imageName: "ayeaye"),
    Monkey(name: "Bald Uakari", imageName: "balduakari"),
    Monkey(name: "Bush Baby", imageName: "bushbaby"),
    Monkey(name: "Chimpanzee", imageName: "chimpanzee"),
    Monkey(name: "Gibbon", imageName: "gibbon"),
    Monkey(name: "Green Monkey", imageName: "green"),
    Monkey(name: "Japanese Macaque", imageName: "japanesemacaque"),
    Monkey(name: "Mandrill", imageName: "mandrill"),
    Monkey(name: "Proboscis Monkey", imageName: "proboscis"),
    Monkey(name: "Pygmy Marmoset", imageName: "pygmymarmoset")
    ]

let hard = [
    Monkey(name: "Allen's Swamp Monkey", imageName: "allensswamp"),
    Monkey(name: "Bonobo", imageName: "bonobo"),
    Monkey(name: "Bornean Orangutan", imageName: "bornean"),
    Monkey(name: "Debrazza's Monkey", imageName: "debrazzas"),
    Monkey(name: "Emperor Tamarin", imageName: "emperor"),
    Monkey(name: "Golden Lion Tamarin", imageName: "goldenlion"),
    Monkey(name: "Golden Snub Nosed Monkey", imageName: "goldensnub"),
    Monkey(name: "Saki", imageName: "saki"),
    Monkey(name: "Sumatran Orangutan", imageName: "sumatran")
    ]

let marathon = [
    // easy
    Monkey(name: "Baboon", imageName: "baboon"),
    Monkey(name: "Capuchin", imageName: "capuchin"),
    Monkey(name: "Gorilla", imageName: "gorilla"),
    Monkey(name: "Howler Monkey", imageName: "howler"),
    Monkey(name: "Lemur", imageName: "lemur"),
    Monkey(name: "Orangutan", imageName: "orangutan"),
    Monkey(name: "Spider Monkey", imageName: "spider"),
    Monkey(name: "Squirrel Monkey", imageName: "squirrel"),
    // medium
    Monkey(name: "Aye Aye", imageName: "ayeaye"),
    Monkey(name: "Bald Uakari", imageName: "balduakari"),
    Monkey(name: "Bush Baby", imageName: "bushbaby"),
    Monkey(name: "Chimpanzee", imageName: "chimpanzee"),
    Monkey(name: "Gibbon", imageName: "gibbon"),
    Monkey(name: "Green Monkey", imageName: "green"),
    Monkey(name: "Japanese Macaque", imageName: "japanesemacaque"),
    Monkey(name: "Mandrill", imageName: "mandrill"),
    Monkey(name: "Proboscis Monkey", imageName: "proboscis"),
    Monkey(name: "Pygmy Marmoset", imageName: "pygmymarmoset"),
    // hard
    Monkey(name: "Allen's Swamp Monkey", imageName: "allensswamp"),
    Monkey(name: "Bonobo", imageName: "bonobo"),
    Monkey(name: "Bornean Orangutan", imageName: "bornean"),
    Monkey(name: "Debrazza's Monkey", imageName: "debrazzas"),
    Monkey(name: "Emperor Tamarin", imageName: "emperor"),
    Monkey(name: "Golden Lion Tamarin", imageName: "goldenlion"),
    Monkey(name: "Golden Snub Nosed Monkey", imageName: "goldensnub"),
    Monkey(name: "Saki", imageName: "saki"),
    Monkey(name: "Sumatran Orangutan", imageName: "sumatran")
]
