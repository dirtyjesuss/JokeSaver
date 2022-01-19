//
//  GetJokeView.swift
//  JokeSaver
//
//  Created by Ruslan Khanov on 19.01.2022.
//

import UIKit

class GetJokeView: UIView, ActionConfigurable {

    // MARK: - Internal properties

    var action: (() -> Void)?

    // MARK: - Views

    private var mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var additionalLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var getJokeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get joke!", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.setTitleColor(.link.withAlphaComponent(0.5), for: .highlighted)
        button.addTarget(self, action: #selector(getJokeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func configure(with model: JokeViewModel) {
        mainLabel.text = model.mainText
        additionalLabel.text = model.additionalText
        categoryLabel.text = "Category: \(model.category ?? "")"
    }

    // MARK: - Private methods

    private func setupStyle() {
        backgroundColor = .white
    }

    private func setupSubviews() {
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(additionalLabel)
        stackView.addArrangedSubview(categoryLabel)

        addSubview(stackView)
        addSubview(getJokeButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            getJokeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            getJokeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            getJokeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Actions

    @objc private func getJokeButtonTapped() {
        action?()
    }
}
