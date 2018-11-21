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
    }

    let originalError: W3C
    let capitalizedError: String

    init(errorResult: [String: String]) {
        self.originalError = W3C(error: errorResult["error"] ?? "",
                                 message: errorResult["message"] ?? "",
                                 stacktrace: errorResult["stacktrace"] ?? "")
        let capitalized = originalError.error
            .trimmingCharacters(in: .whitespaces)
            .capitalized
            .components(separatedBy: .whitespaces)
            .joined()
        self.capitalizedError = "\(capitalized)Error"
    }

    func raise() throws {
        switch self.capitalizedError {
        case "SessionNotCreatedError":
            throw WebDriverErrorEnum.sessionNotCreatedError(error: originalError)
        case "InvalidSessionIdError":
            throw WebDriverErrorEnum.invalidSessionIdError(error: originalError)
        case "NoSuchElementError":
            throw WebDriverErrorEnum.noSuchElementError(error: originalError)
        default:
            throw WebDriverErrorEnum.webDriverError(error: originalError)
        }
    }
}
