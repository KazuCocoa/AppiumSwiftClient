//
//  CommandProtocol.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

protocol CommandProtocol {
    // Generate Command URL with parsing Session.Id and Element.Id
    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id) -> W3CCommands.CommandPath

    // func sendRequest()

    // func generateBodyDat()

    // fileprivate struct CommandParam : CommandParamProtocol
}
