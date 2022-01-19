//
//  JokesService.swift
//  JokeSaver
//
//  Created by Ruslan Khanov on 19.01.2022.
//

import Foundation

typealias JokeRequestCompletion = (Result<Joke, Error>) -> Void

protocol JokesService: AnyObject {
    func getJoke(completion: @escaping JokeRequestCompletion)
}

final class JokesServiceImp: JokesService {

    // MARK: - Private properties

    private let url: URL = {
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Any?") else {
            fatalError("Incorrect url")
        }

        return url
    }()

    // MARK: JokesService methods

    func getJoke(completion: @escaping JokeRequestCompletion) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let data = data else {
                completion(.failure(NSError()))
                return
            }

            do {
                completion(.success(try self.decodeJoke(from: data)))
            } catch {
                completion(.failure(error))
            }

        }
    }

    // MARK: - Private methods

    private func decodeJoke(from data: Data) throws -> Joke  {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Joke.self, from: data)
    }
}
