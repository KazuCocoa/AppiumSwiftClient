//
//  Commands.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public struct W3CCommands {
    typealias Method = HttpMethod
    typealias CommandPath = String

    // Session
    static let newSession: (Method, CommandPath) = (HttpMethod.post, "session")
    static let deleteSession: (Method, CommandPath) = (HttpMethod.delete, "session/:sessionId") // TODO: replace :sessionId to proper value
}

