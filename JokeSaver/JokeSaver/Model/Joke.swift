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

    enum CodingKeys: String, CodingKey {
        case id, category, type, flags,
             joke, setup, delivery
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(JokeType.self, forKey: .type)
        flags = try container.decode(Flags.self, forKey: .flags)
        joke = try? container.decode(String?.self, forKey: .joke)
        setup = try? container.decode(String?.self, forKey: .setup)
        delivery = try? container.decode(String?.self, forKey: .delivery)
    }
}
