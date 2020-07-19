//
//  HomeScreen.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 05.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
@testable import AppiumSwiftClient

struct HomeScreen {

    private var driver: AppiumDriver!

    init(_ driver: AppiumDriver) {
        self.driver = driver
    }

    func textFieldsBtn() -> MobileElement {
        return try! driver.findElement(by: .name, with: "TextFields")
    }

    func buttonsBtn() -> MobileElement {
        return try! driver.findElement(by: .accessibilityId, with: "Buttons")
    }
    
    func segmentsBtn() -> MobileElement {
        return try! driver.findElement(by: .accessibilityId, with: "Segments")
    }
}
