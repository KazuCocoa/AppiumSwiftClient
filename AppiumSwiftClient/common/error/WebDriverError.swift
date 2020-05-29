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
        let data: W3CData?
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

    /*
     POC: Overload constructor that accepts error Data as argument, subsequentially should decode to Object Value of type W3C
     */
    init(errorResult: Data) {
        self.originalError = try! JSONDecoder().decode(ValueOf<W3C>.self, from: errorResult).value // swiftlint:disable:this force_try
        let capitalized = originalError.error
            .trimmingCharacters(in: .whitespaces)
            .capitalized
            .components(separatedBy: .whitespaces)
            .joined()
        self.capitalizedError = "\(capitalized)Error"
    }

    /*
     POC: Refactor raise function to throw Error so we can throw it at Command implementation level
     instead of returning a fabicated response in case of failure
     */
    func raise() throws -> Error {
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

/*
 POC: Generic struct that accepts decodable conformant types that represents a driver response. It is meant
 to be a reusable struct and should be placed in its own file and used whenever fit (Mostly POST request
 responses as it does not decode sessionId value?)
 */
struct ValueOf<T: Decodable>: Decodable {
    let value: T

    private enum CodingKeys: String, CodingKey {
            case value
        }

        init(from decoder: Decoder) {
            let container = try! decoder.container(keyedBy: CodingKeys.self) // swiftlint:disable:this force_try
            value = try! container.decode(T.self, forKey: .value) // swiftlint:disable:this force_try
        }
}
