//
//  GetJokeViewController.swift
//  JokeSaver
//
//  Created by Ruslan Khanov on 19.01.2022.
//

import UIKit

class GetJokeViewController: UIViewController {

    private var getJokeView: GetJokeView?
    private var jokeService: JokesService

    init(jokeService: JokesService) {
        self.jokeService = jokeService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Joke Saver"

        getJokeView?.action = { [weak self] in
            self?.getJokeView?.startLoading()
            self?.jokeService.getJoke { result in
                switch result {
                case .success(let joke):
                    DispatchQueue.main.async {
                        self?.getJokeView?.configure(with: JokeViewModel(
                            mainText: joke.joke ?? joke.setup,
                            additionalText: joke.delivery,
                            category: joke.category
                        ))
                        self?.getJokeView?.stopLoading()
                    }

                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.getJokeView?.stopLoading()
                    }
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func loadView() {
        getJokeView = GetJokeView()
        view = getJokeView
    }
}
