//
//  TextFieldsScreen.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 05.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
@testable import AppiumSwiftClient

struct TextFieldsScreen {

    private var driver: AppiumDriver!

    init(_ driver: AppiumDriver) {
        self.driver = driver
    }

    func roundedTextField() -> MobileElement {
        return try! driver.findElement(by: .predicate, with: "label == \"Rounded\"")
    }

    func sendKeyTestText() -> MobileElement {
        return try! driver.findElement(by: .predicate, with: "value == \"Send Keys Test\"")
    }
}
