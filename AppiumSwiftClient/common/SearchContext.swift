//
//  SearchContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public enum SearchContext: String {
    case `class`, className = "class name"
    case css = "css selector"
    case id = "id" // swiftlint:disable:this identifier_name
    case link, linkText = "link text"
    case name = "name"
    case partialLinkText = "partial link text"
    case tagName = "tag name"
    case xpath = "xpath"
    case accessibilityId = "accessibility id"
    case image = "-image"
    case custom = "-custom"

    // Android
    case uiautomator = "-android uiautomator"
    case viewTag = "-android viretag"

    // iOS
    case predicate = "-ios predicate string"
    case classChain = "-ios class chain"

    // Windows
    case windowsUiautomation = "-windows uiautomation"

    // Tizen
    case tizenUiautomation = "-tizen uiautomation"
}
