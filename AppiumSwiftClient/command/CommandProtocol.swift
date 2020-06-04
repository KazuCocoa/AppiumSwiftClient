//
//  CommandProtocol.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

protocol CommandProtocol {
    // Generate Command URL with parsing Session.Id and Element.Id
//    func commandUrl(with sessionId: Session.Id, and elementId: Element.Id) -> W3CCommands.CommandPath

    // Handle a request
    // func sendRequest()

    // Generate json body to Appium server
    // func generateBodyData()

    // fileprivate struct CommandParam : CommandParamProtocol
}

// Decoder
public struct ValueOf<T: Decodable>: Decodable {
    let value: T

    private enum CodingKeys: String, CodingKey {
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            value = try container.decode(T.self, forKey: .value)
        } catch {
            do {
                value = try container.decode([T].self, forKey: .value) as! T // swiftlint:disable:this force_cast
            } catch let error {
                throw DecodingError.decodingError(error)
            }
        }
    }
}

enum DecodingError: Error {
    case decodingError(Error)
}
