//
//  Client.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct HttpClient {
    let endpoint: String

    init(endpoint: String = "") {
        self.endpoint = endpoint.isEmpty ? "http://127.0.0.1:4723/wd/hub/" : endpoint
    }

    func sendSyncRequest(method: HttpMethod, commandPath: String, json: Data) -> (Int, [String: Any]) {
        let uri = "\(endpoint)\(commandPath)"

        var returnValue: [String: Any] = ["value": ""]
        var statusCode: Int = 0

        guard let url = URL(string: uri) else {
            print("failed to create session")
            return (0, returnValue)
        }

        let semaphore = DispatchSemaphore(value: 0)

        var commandURLRequest = URLRequest(url: url)
        commandURLRequest.httpMethod = method.rawValue
        commandURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        commandURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        commandURLRequest.timeoutInterval = 60.0 // 60 secons

        if method == HttpMethod.post {
            commandURLRequest.httpBody = json
        }

        let session = URLSession.shared

        let task = session.dataTask(with: commandURLRequest) { (data, response, error) in
            if let resp = response {
                statusCode = (resp as! HTTPURLResponse).statusCode // swiftlint:disable:this force_cast
            }

            guard let responseData = data, error == nil else {
                print("Error calling \(method.rawValue) on \(uri)")
                return
            }

            returnValue =  WebDriverResponseValue(responseJsonData: responseData)
                .value as! [String: Any] // swiftlint:disable:this force_cast
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        return (statusCode, returnValue)
    }

    struct WebDriverResponseValue {
        let value: Any

        init(responseJsonData: Data) {
            do {
                guard let jsonValue =
                    try JSONSerialization.jsonObject(with: responseJsonData, options: []) as? [String: Any] else {
                        print("Could not get JSON from responseData as dictionary")
                        value = "Invalid JSON format"
                        return
                }

                value = jsonValue
            } catch {
                print("Error parsing response from POST")
                value = "Invalid JSON format"
                return
            }
        }
    }
}
