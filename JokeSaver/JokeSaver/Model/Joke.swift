//
//  Joke.swift
//  JokeSaver
//
//  Created by Ruslan Khanov on 19.01.2022.
//

import Foundation

struct Joke: Decodable {

    // MARK: - Nested types

    enum JokeType: String, Decodable {
        case single
        case twoPart = "twopart"
    }

    struct Flags: Decodable {
        let nsfw: Bool
        let religious: Bool
        let political: Bool
        let racist: Bool
        let sexist: Bool
        let explicit: Bool
    }

    // MARK: - Fields

    let id: Int
    let category: String
    let type: JokeType
    let flags: Flags

    // For single joke
    let joke: String?

    // For two part joke
    let setup: String?
    let delivery: String?
}
