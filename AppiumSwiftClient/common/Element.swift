//
//  Element.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public class Element {
    public typealias Id = String

    public let id: Id
    public let sessionId: Session.Id // TODO: remove session id from element class since it should not depend on here

    init(id: Id, sessionId: Session.Id) {
        self.id = id
        self.sessionId = sessionId
    }

    public func click() {
        let result = W3CElementClick().sendRequest(self.id, with: sessionId)

        guard result != "" else {
            print(result)
            return
        }
    }
}
