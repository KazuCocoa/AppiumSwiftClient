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

    enum Id : String {
        case Session = ":sessionId"
        case Element = ":elementId"
    }

    // Session
    static let newSession:        CommandType = (HttpMethod.post,   "session")
    static let deleteSession:     CommandType = (HttpMethod.delete, "session/\(Id.Session.rawValue)")

    // Element
    static let findElement:       CommandType = (HttpMethod.post,  "session/\(Id.Session.rawValue)/element")
    static let findElements:      CommandType = (HttpMethod.post,  "session/\(Id.Session.rawValue)/elements")
    static let findChildElement:  CommandType = (HttpMethod.post,  "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/element")
    static let findChildElements: CommandType = (HttpMethod.post,  "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/elements")

    // Action
    static let elementClick:      CommandType = (HttpMethod.post,  "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/click")
}
