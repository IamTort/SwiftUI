// String+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение строки для создания маски телефонного номера
extension String {
    // MARK: - Private Constants

    private enum Constants {
        static let emptyString = ""
        static let targetString = "[^0-9]"
        static let spaceString = " "
        static let phoneFormatString = "+X (XXX) XXX-XX-XX"
        static let cardFormatString = "XXXX XXXX XXXX XXXX"
        static let elementChar: Character = "X"
        static let resultContainsString = "+7"
        static let elementCharacter: Character = "7"
    }

    // MARK: - Public methods

    func makeNumberString() -> String {
        replacingOccurrences(of: Constants.targetString, with: Constants.emptyString, options: .regularExpression)
    }

    func removeAllSpace() -> String {
        replacingOccurrences(of: Constants.spaceString, with: Constants.emptyString)
    }

    func formatPhone(with mask: String) -> String {
        let numbers = removeAllSpace().makeNumberString()
        var result = Constants.emptyString
        var index = numbers.startIndex
        for ch in mask.enumerated() where index < numbers.endIndex {
            if ch.element == Constants.elementChar {
                if !result.contains(Constants.resultContainsString), numbers.first != Constants.elementCharacter {
                    result.append(Constants.elementCharacter)
                }
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch.element)
            }
        }
        return result
    }

    func phoneFormat() -> String {
        formatPhone(with: Constants.phoneFormatString)
    }

    func cardFormat() -> String {
        formatPhone(with: Constants.cardFormatString)
    }
}
