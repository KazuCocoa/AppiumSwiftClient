//
//  SegmentsScreen.swift
//  AppiumFuncTests
//
//  Created by Gabriel Fioretti on 20.07.20.
//  Copyright © 2020 KazuCocoa. All rights reserved.
//

import Foundation
@testable import AppiumSwiftClient

struct SegmentsScreen {

    private var driver: AppiumDriver!

    init(_ driver: AppiumDriver) {
        self.driver = driver
    }

    func searchBtn() -> MobileElement {
        return try! driver.findElement(by: .accessibilityId, with: "Search")
    }

    func checkBtn() -> MobileElement {
        return try! driver.findElement(by: .accessibilityId, with: "Check")
    }
}
