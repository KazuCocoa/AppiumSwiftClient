//
//  WebDriverError.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/15.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

protocol WebDriverErrorProtocol {
}

struct WebDriverError : WebDriverErrorProtocol {
    let error: String
    let message: String
    let stacktrace: String

    init(errorResult: WebDriverErrorEnum.Error) {
        let formattedError = (errorResult["error"] ?? "").trimmingCharacters(in: .whitespaces).capitalized

        self.error = "\(formattedError)Error" // TODO: This should match with Enum type
        self.message = errorResult["message"] ?? ""
        self.stacktrace = errorResult["stacktrace"] ?? ""
    }
}
