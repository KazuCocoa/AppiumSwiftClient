//
//  ButtonsScreen.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 05.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
@testable import AppiumSwiftClient

struct ButtonsScreen {

    private var driver: AppiumDriver!

    init(_ driver: AppiumDriver) {
        self.driver = driver
    }

    func grayBtn() -> MobileElement {
        return try! driver.findElement(by: .name, with: "Gray")
    }
}
