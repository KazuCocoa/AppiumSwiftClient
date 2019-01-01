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

    // Handle a request
    // func sendRequest()

    // Generate json body to Appium server
    // func generateBodyData()

    // fileprivate struct CommandParam : CommandParamProtocol
}
