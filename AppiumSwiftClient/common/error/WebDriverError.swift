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
    //    {
    //        "value": {
    //            "error": "unexpected alert open",
    //            "message": "",
    //            "stacktrace": "",
    //            "data": { // optional
    //                "text": "Message from window.alert"
    //            }
    //        }
    //    }
    public struct W3C: Codable {
        let error: String
        let message: String
        let stacktrace: String
        let data: W3CData
    }

    public struct W3CData: Codable {
        let text: String
    }

    let originalError: W3C
    let capitalizedError: String

    init(errorResult: [String: String]) {
        self.originalError = W3C(error: errorResult["error"] ?? "",
                                 message: errorResult["message"] ?? "",
                                 stacktrace: errorResult["stacktrace"] ?? "",
                                 data: W3CData(text: "")) // TODO: Add "data" { "text": "xxxx" }

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
        case "NoSuchContextError":
            throw WebDriverErrorEnum.noSuchContextError(error: originalError)
        case "InvalidArgumentError":
            throw WebDriverErrorEnum.invalidArgumentError(error: originalError)
        case "UnknownErrorError":
            throw WebDriverErrorEnum.unknownError(error: originalError)
        default:
            throw WebDriverErrorEnum.webDriverError(error: originalError)
        }
    }
}
