//
//  ActionConfigurable.swift
//  JokeSaver
//
//  Created by Ruslan Khanov on 19.01.2022.
//

import Foundation

protocol ActionConfigurable {
    var action: (() -> Void)? { get set }
}
