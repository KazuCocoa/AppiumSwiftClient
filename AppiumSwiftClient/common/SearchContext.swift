//
//  SearchContext.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public enum SearchContext : String {
    case Class, ClassName = "class name"
    case Css = "css selector"
    case Id = "id"
    case Link, LinkText = "link text"
    case Name = "name"
    case PartialLinkText = "partial link text"
    case TagName = "tag name"
    case Xpath = "xpath"
    case AccessibilityId = "accessibility id"
    case Image = "-image"
    case Custom = "-custom"

    // Android
    case Uiautomator = "-android uiautomator"
    case ViewTag = "-android viretag"

    // iOS
    case Predicate = "-ios predicate string"
    case ClassChain = "-ios class chain"

    // Windows
    case WindowsUiautomation = "-windows uiautomation"

    // Tizen
    case TizenUiautomation = "-tizen uiautomation"
}
