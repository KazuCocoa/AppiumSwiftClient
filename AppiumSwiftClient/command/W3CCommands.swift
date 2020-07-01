//
//  Commands.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

// swiftlint:disable comma line_length colon
public struct W3CCommands {
    typealias Method = HttpMethod
    typealias CommandPath = String
    typealias CommandType = (Method, CommandPath)

    enum Id: String { // swiftlint:disable:this type_name
        case session = ":sessionId"
        case element = ":elementId"
    }

    enum Attribute: String {
        case name = ":name"
        case propertyName = ":property_name"
    }

    /**
     Get a path of W3CCommands with given session id and element id.
    **/
    func url(for urlBase: CommandType, with sessionId: Session.Id = "", and elementId: MobileElement.Id = "") -> W3CCommands.CommandPath {
        let commandUrl = urlBase.1
            .replacingOccurrences(of: W3CCommands.Id.session.rawValue, with: sessionId)
            .replacingOccurrences(of: W3CCommands.Id.element.rawValue, with: elementId)
        return commandUrl
    }

    // Session
    static let newSession:              CommandType = (HttpMethod.post,   "session")
    static let deleteSession:           CommandType = (HttpMethod.delete, "session/\(Id.session.rawValue)")

    // Basic Driver
    static let get:                     CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/url")
    static let getCurrentUrl:           CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/url")
    static let back:                    CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/back")
    static let forward:                 CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/forward")
    static let refresh:                 CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/refresh")
    static let getTitle:                CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/title")

    // window and Frame handling
    static let getWindowHandle:         CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/window")
    static let closeWindow:             CommandType = (HttpMethod.delete, "session\(Id.session.rawValue)/window")
    static let switchToWindow:          CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window")
    static let getWindowHandles:        CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/window/handles")
    static let fullScreenWindow:        CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/fullscreen")
    static let minimizeWindow:          CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/minimize")
    static let mazimizeWindow:          CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/maximize")
    static let setWindowSize:           CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/size")
    static let getWindowSize:           CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/window/size")
    static let setWindowPosition:       CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/position")
    static let getWindowPosition:       CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/window/position")
    static let setWindowRect:           CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/window/rect")
    static let getWindowRect:           CommandType = (HttpMethod.get,    "session\(Id.session.rawValue)/window/rect")
    static let switchToFrame:           CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/frame")
    static let switchToParentFrame:     CommandType = (HttpMethod.post,   "session\(Id.session.rawValue)/frame/parent")

    // Element
    static let findElement:             CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element")
    static let findElements:            CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/elements")
    static let findChildElement:        CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/element")
    static let findChildElements:       CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/elements")
    static let getActiveElement:        CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/active")
    static let isElementSelected:       CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/selected")
    static let getElementAttribute:     CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/attribute/\(Attribute.name.rawValue)")
    static let getElementProperty:      CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/property/\(Attribute.name.rawValue)")
    static let getElementCssValue:      CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/css/\(Attribute.propertyName.rawValue)")
    static let getElementText:          CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/text")
    static let getElementTagName:       CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/name")
    static let getElementRect:          CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/rect")
    static let isElementEnabled:        CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/enabled")

    // Document Handling
    static let getPageSource:           CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/source")
    static let executeScript:           CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/execute/sync")
    static let executeAsyncScript:      CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/execute/async")

    // Cookies
    static let getAllCookies:           CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/cookie")
    static let getCookie:               CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/cookie/\(Attribute.name.rawValue)")
    static let addCookie:               CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/cookie")
    static let deleteCookie:            CommandType = (HttpMethod.delete, "session/\(Id.session.rawValue)/cookie/\(Attribute.name.rawValue)")
    static let deleteAllCookie:         CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/cookie")

    // Timeouts
    static let setTimeout:              CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/timeouts")

    // Actions
    static let actions:                 CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/actions")
    static let releaseActions:          CommandType = (HttpMethod.delete, "session/\(Id.session.rawValue)/actions")

    // Element Operations
    static let elementClick:            CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/click")
    static let elementTap:              CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/tap")
    static let elementClear:            CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/clear")
    static let elementSendKeys:         CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/value")

    // Alerts
    static let dismissAlert:            CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/alert/dismiss")
    static let acceptAlert:             CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/alert/accept")
    static let getAlertText:            CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/alert/text")
    static let sendAlertText:           CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/alert/text")

    // Screenshot
    static let takeScreenshot:          CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/screenshot")
    static let takeElementScreenshot:   CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/screenshot")

    // Server Extensions
    static let uploadFile:              CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/se/file")

    // For Appium, extend W3C using MJSONWP based commands

    // Session
    static let status:                  CommandType = (HttpMethod.get,    "status")
    static let isElementDisplayed:      CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/element/\(Id.element.rawValue)/displayed")

    static let getTimeouts:             CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/timeouts")

    static let getCapabilities:         CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)")

    static let getScreenOrientation:    CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/orientation")
    static let setScreenOrientation:    CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/orientation")

    static let getLocation:             CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/location")
    static let setLocation:             CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/location")

    static let getSettings:             CommandType = (HttpMethod.get, "session/\(Id.session.rawValue)/appium/settings")

    static let setSettings:             CommandType = (HttpMethod.post, "session/\(Id.session.rawValue)/appium/settings")

    static let imeGetAvailableEngines:  CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/ime/available_engines")
    static let imeGetActiveEngine:      CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/ime/active_engine")
    static let imeIsActivated:          CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/ime/activated")
    static let imeDeactivate:           CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/ime/deactivate")
    static let imeActivateEngine:       CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/ime/activate")

    static let sendKeysToActiveElement: CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/keys")

    static let getAvailableLogTypes:    CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/log/types")
    static let getLog:                  CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/log")
    static let logEvent:                CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/appium/log_event")
    static let getEvents:               CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/appium/events")

    // Common
    static let getAvailableContexts:    CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/contexts")
    static let setContext:              CommandType = (HttpMethod.post,   "session/\(Id.session.rawValue)/context")
    static let getCurrentContext:       CommandType = (HttpMethod.get,    "session/\(Id.session.rawValue)/context")
}
