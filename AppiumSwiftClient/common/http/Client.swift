//
//  Client.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

struct HttpClient {
    let endpoint = "http://127.0.0.1:4723/wd/hub/"

    func sendSyncRequest(method: HttpMethod, commandPath: String, json: Data) -> Any {
        let uri = "\(endpoint)\(commandPath)"

        var returnValue : Any = ""

        guard let url = URL(string: uri) else {
            print("failed to create session")
            return returnValue
        }

        let semaphore = DispatchSemaphore(value: 0)

        var commandURLRequest = URLRequest(url: url)
        commandURLRequest.httpMethod = method.rawValue
        commandURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        commandURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        commandURLRequest.timeoutInterval = 60.0 // 60 secons
        commandURLRequest.httpBody = json

        let session = URLSession.shared

        let task = session.dataTask(with: commandURLRequest) { (data, response, error) in
            guard let responseData = data, error == nil else {
                print("Error calling \(method.rawValue) on \(uri)")
                return
            }

            returnValue =  WebDriverResponseValue(responseJsonData: responseData).value as! [String : Any]
            semaphore.signal()
        }
        task.resume()
        let _ = semaphore.wait(timeout: .distantFuture)

        return returnValue
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
}
