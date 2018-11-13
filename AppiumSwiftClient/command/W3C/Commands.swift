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
    typealias CommandType = (Method, CommandPath)

    // Session
    static let newSession: CommandType = (HttpMethod.post, "session")
    static let deleteSession: CommandType = (HttpMethod.delete, "session/:sessionId") // TODO: replace :sessionId to proper value

    // Element
    static let findElement: CommandType = (HttpMethod.post, "session/:sessionId/element")
    static let findElements: CommandType = (HttpMethod.post, "session/:sessionId/elements")
    static let findChildElement: CommandType = (HttpMethod.post, "session/:sessionId/element/:id/element")
    static let findChildElements: CommandType = (HttpMethod.post, "session/:sessionId/element/:id/elements")

    // Action
    static let elementClick: CommandType = (HttpMethod.post, "session/:sessionId/element/:id/click")
}
