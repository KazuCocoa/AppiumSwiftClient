//
//  error.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//
public enum WebDriverError: Error {
    public typealias Error = [String: String]
    //            ["value": {
    //                error = "no such element";
    //                message = "An element could not be located on the page using the given search parameters.";
    //                stacktrace = "NoSuchElementError: An element could not be located on the page using the given search parameters.\n    at XCUITestDriver.<anonymous> (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/lib/commands/find.js:130:13)\n    at Generator.throw (<anonymous>)\n    at asyncGeneratorStep (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:3:24)\n    at _throw (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:29:9)\n    at <anonymous>";
    //                }]
    case NoSuchElementError(error: Error)
}
