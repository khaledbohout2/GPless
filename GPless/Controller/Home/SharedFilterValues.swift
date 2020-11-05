//
//  SharedFilterValues.swift
//  GPless
//
//  Created by Khaled Bohout on 11/5/20.
//

import Foundation

public class SharedFilterValues {

    // MARK: - Properties

    static let shared = SharedFilterValues(lowValue: 0.0)
    weak var delegate: SingletonDelegate?

    // MARK: -

    var lowValue: Double = 0 {
        didSet {
           delegate?.variableDidChange(newlowValue: lowValue)
        }
     }

    // Initialization

    private init(lowValue: Double) {
        self.lowValue = lowValue
    }

}

protocol SingletonDelegate: class {
    func variableDidChange(newlowValue value: Double)
}
