// PhoneNumberFormatter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Маска для введения номера телефона
final class PhoneNumberFormatter: Formatter {
    // MARK: - Public methods

    override func string(for obj: Any?) -> String? {
        guard let string = obj as? String else {
            return nil
        }
        return addSpaceBetweenEverySymbol(string)
    }

    override func getObjectValue(
        _ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
        for string: String,
        errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?
    ) -> Bool {
        obj?.pointee = addSpaceBetweenEverySymbol(string) as AnyObject
        return true
    }
}

extension PhoneNumberFormatter {
    func addSpaceBetweenEverySymbol(_ string: String) -> String {
        string.phoneFormat()
    }
}
