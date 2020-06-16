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

    // TODO base endpoint should be given at the driver instantiation time
    init(endpoint: String = "") {
        self.endpoint = endpoint.isEmpty ? "http://127.0.0.1:4723/wd/hub/" : endpoint
    }

    // Maybe refactor this method to accept commandPath as final url as URL type?
    func sendSyncRequest(method: HttpMethod, commandPath: String, json: Data = "{}".data(using: .utf8)!) -> (Int, Data) {

        let uri = "\(endpoint)\(commandPath)"

        var returnData: Data = "".data(using: .utf8)!
        var statusCode: Int = 0

        guard let url = URL(string: uri) else {
            print("failed to create session")
            return (0, returnData)
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

            returnData = responseData
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        return (statusCode, returnData)
    }
}
