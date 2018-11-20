//
//  Element.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public struct Element {
    public typealias Id = String // swiftlint:disable:this type_name

    public let id: Id // swiftlint:disable:this identifier_name
    public let sessionId: Session.Id // TODO: remove session id from element class since it should not depend on here

    init(id: Id, sessionId: Session.Id) { // swiftlint:disable:this identifier_name
        self.id = id
        self.sessionId = sessionId
    }

    public func click() -> String {
        let result = W3CElementClick().sendRequest(self.id, with: sessionId)

        guard result != "" else {
            print(result)
            return result
        }

        return result
    }
}
