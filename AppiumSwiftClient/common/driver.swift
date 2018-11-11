//
//  driver.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

protocol Driver {
    func createSession(with caps: AppiumCapabilities) -> String
}

// sessionId should be global id.
// Will create Class as the driver. All of methods are struct. The class has them.
public class AppiumDriver : Driver {

    public var currentSessionCapabilities: AppiumCapabilities

    public init(_ caps: AppiumCapabilities) {
        currentSessionCapabilities = caps

        currentSessionCapabilities = handShake(desiredCapability: caps)
    }

    private func handShake(desiredCapability: AppiumCapabilities) -> AppiumCapabilities {
        var caps = desiredCapability.capabilities()
        let sessionId = createSession(with: desiredCapability)

        caps[.sessionId] = sessionId

        return AppiumCapabilities(caps)
    }

    internal func createSession(with caps: AppiumCapabilities) -> String {
        let json = generateCapabilityBodyData(with: caps)
        // TODO: send HTTP request to server as JSON format
        let id = sendRequest(json: json)
        return id
    }

    enum HttpMethod : String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case head = "HEAD"
        case delete = "DELETE"
        case patch = "PATCH"
        case trace = "TRACE"
        case options = "OPTIONS"
        case connect = "CONNECT"
    }

    private func sendRequest(json: Data) -> String {
        let endpoint = "http://127.0.0.1:4723/wd/hub/session"
        guard let url = URL(string: endpoint) else {
            return "failed to create session"
        }

        let semaphore = DispatchSemaphore(value: 0)

        var createSessionURLRequest = URLRequest(url: url)
        createSessionURLRequest.httpMethod = HttpMethod.post.rawValue
        createSessionURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        createSessionURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        createSessionURLRequest.timeoutInterval = 60.0 // 60 secons
        createSessionURLRequest.httpBody = json

        let session = URLSession.shared
        var result = "no session"

        let task = session.dataTask(with: createSessionURLRequest) { (data, response, error) in
            guard let responseData = data, error == nil else {
                print("error calling POST on \(endpoint)")
                result = "no session because of an error"
                return
            }

            let value =  WebDriverResponseValue.init(responseJsonData: responseData).value as! [String : Any]
            result = value["sessionId"] as! String
            semaphore.signal()
        }
        task.resume()
        let _ = semaphore.wait(timeout: .distantFuture)

        // The body will be:
        // {"value":{"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","capabilities":{"device":"iphone","browserName":"UICatalog","sdkVersion":"11.4","CFBundleIdentifier":"com.example.apple-samplecode.UICatalog"}},"sessionId":"9C9D08C2-6024-4132-8E2C-D2292672C0E2","status":0}
        return result
    }

    struct WebDriverResponseValue {
        let value: Any

        init(responseJsonData: Data) {
            do {
                guard let jsonValue = try JSONSerialization.jsonObject(with: responseJsonData, options: []) as? [String: Any] else {
                    print("Could not get JSON from responseData as dictionary")
                    value = "Invalid JSON format"
                    return
                }

                value = jsonValue["value"] as Any
            } catch {
                print("Error parsing response from POST")
                value = "Invalid JSON format"
                return
            }
        }
    }


    // TODO: duplicated
    public func generateCapabilityBodyData(with caps: AppiumCapabilities) -> Data {
        let invalidJson = "Not a valid JSON"

        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let w3cFirstMatch = W3CFirstMatch(firstMatch: [w3cDesiredCapability])

        let w3cCapability = W3CCapability(desiredCapabilities: oSSdesiredCapability, capabilities: w3cFirstMatch)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys

        do {
            return try encoder.encode(w3cCapability)
        } catch {
            return invalidJson.data(using: .utf8)!
        }
    }
    public func generateCapabilityBody(with caps: AppiumCapabilities) -> String {
        let invalidJson = "Not a valid JSON"

        let oSSdesiredCapability = OssDesiredCapability(with: caps)

        let w3cDesiredCapability = W3CDesiredCapability(with: caps)
        let w3cFirstMatch = W3CFirstMatch(firstMatch: [w3cDesiredCapability])

        let w3cCapability = W3CCapability(desiredCapabilities: oSSdesiredCapability, capabilities: w3cFirstMatch)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            let json = try encoder.encode(w3cCapability)
            return String(data: json, encoding: .utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

internal struct W3CCapability : Codable {
    let desiredCapabilities : OssDesiredCapability
    let capabilities : W3CFirstMatch
}

internal struct W3CFirstMatch : Codable {
    let firstMatch : [W3CDesiredCapability]
}
