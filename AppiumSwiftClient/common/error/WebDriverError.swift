//
//  WebDriverError.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/15.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

protocol WebDriverErrorProtocol {

}

public struct WebDriverError: WebDriverErrorProtocol {

    public struct W3C: Codable {
        let error: String
        let message: String
        let stacktrace: String
        let data: W3CData?
    }

    public struct W3CData: Codable {
        let text: String
    }

    let originalError: W3C
    let capitalizedError: String

    init(errorResult: Data) {
        self.originalError = try! JSONDecoder().decode(ValueOf<W3C>.self, from: errorResult).value
        let capitalized = originalError.error
            .trimmingCharacters(in: .whitespaces)
            .capitalized
            .components(separatedBy: .whitespaces)
            .joined()
        self.capitalizedError = "\(capitalized)Error"
    }

    func raise() -> WebDriverErrorEnum {
        switch self.capitalizedError {
        case "SessionNotCreatedError":
            return WebDriverErrorEnum.sessionNotCreatedError(error: originalError)
        case "InvalidSessionIdError":
            return WebDriverErrorEnum.invalidSessionIdError(error: originalError)
        case "NoSuchElementError":
            return WebDriverErrorEnum.noSuchElementError(error: originalError)
        case "NoSuchContextError":
            return WebDriverErrorEnum.noSuchContextError(error: originalError)
        case "InvalidArgumentError":
            return WebDriverErrorEnum.invalidArgumentError(error: originalError)
        case "UnknownErrorError":
            return WebDriverErrorEnum.unknownError(error: originalError)
        case "InvalidElementStateError":
            return WebDriverErrorEnum.invalidElementStateError(error: originalError)
        default:
            return WebDriverErrorEnum.webDriverError(error: originalError)
        }
    }
}
