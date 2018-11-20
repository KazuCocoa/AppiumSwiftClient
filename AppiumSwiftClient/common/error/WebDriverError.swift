//
//  WebDriverError.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/15.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

protocol WebDriverErrorProtocol {
}

struct WebDriverError: WebDriverErrorProtocol {
    let originalError: WebDriverErrorEnum.Error

    let capitalizedError: String
    let error: String
    let message: String
    let stacktrace: String

    init(errorResult: WebDriverErrorEnum.Error) {
        self.originalError = errorResult
        self.error = errorResult["error"] ?? ""
        self.message = errorResult["message"] ?? ""
        self.stacktrace = errorResult["stacktrace"] ?? ""

        let capitalized = error
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
