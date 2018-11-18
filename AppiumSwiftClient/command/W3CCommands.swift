//
//  Commands.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/12.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public struct W3CCommands {
    typealias Method = HttpMethod
    typealias CommandPath = String
    typealias CommandType = (Method, CommandPath)

    enum Id : String {
        case Session = ":sessionId"
        case Element = ":elementId"
    }

    enum Attribute : String {
        case Name = ":name"
        case PropertyName = ":property_name"
    }

    /**
     Get a path of W3CCommands with given session id and element id.
    **/
    func url(for urlBase: CommandType, with sessionId: Session.Id = "", and elementId: Element.Id = "") -> W3CCommands.CommandPath {
        let commandUrl = urlBase.1
            .replacingOccurrences(of: W3CCommands.Id.Session.rawValue, with: sessionId)
            .replacingOccurrences(of: W3CCommands.Id.Element.rawValue, with: elementId)
        return commandUrl
    }

    // Session
    static let newSession:              CommandType = (HttpMethod.post,   "session")
    static let deleteSession:           CommandType = (HttpMethod.delete, "session/\(Id.Session.rawValue)")

    // Basic Driver
    static let get:                     CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/url")
    static let getCurrentUrl:           CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/url")
    static let back:                    CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/back")
    static let forward:                 CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/forward")
    static let refresh:                 CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/refresh")
    static let getTitle:                CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/title")

    // window and Frame handling
    static let getWindowHandle:         CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/window")
    static let closeWindow:             CommandType = (HttpMethod.delete, "session\(Id.Session.rawValue)/window")
    static let switchToWindow:          CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window")
    static let getWindowHandles:        CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/window/handles")
    static let fullScreenWindow:        CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/fullscreen")
    static let minimizeWindow:          CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/minimize")
    static let mazimizeWindow:          CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/maximize")
    static let setWindowSize:           CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/size")
    static let getWindowSize:           CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/window/size")
    static let setWindowPosition:       CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/position")
    static let getWindowPosition:       CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/window/position")
    static let setWindowRect:           CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/window/rect")
    static let getWindowRect:           CommandType = (HttpMethod.get,    "session\(Id.Session.rawValue)/window/rect")
    static let switchToFrame:           CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/frame")
    static let switchToParentFrame:     CommandType = (HttpMethod.post,   "session\(Id.Session.rawValue)/frame/parent")

    // Element
    static let findElement:             CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element")
    static let findElements:            CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/elements")
    static let findChildElement:        CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/element")
    static let findChildElements:       CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/elements")
    static let getActiveElement:        CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/active")
    static let isElementSelected:       CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/selected")
    static let getElementAttribute:     CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/attribute/\(Attribute.Name.rawValue)")
    static let getElementProperty:      CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/property/\(Attribute.Name.rawValue)")
    static let getElementCssValue:      CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/css/\(Attribute.PropertyName.rawValue)")
    static let getElementText:          CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/text")
    static let getElementTagName:       CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/name")
    static let getElementRect:          CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/rect")
    static let isElementEnabled:        CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/enabled")

    // Document Handling
    static let getPageSource:           CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/source")
    static let execute_script:          CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/execute/sync")
    static let execute_async_script:    CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/execute/async")

    // Cookies
    static let getAllCookies:           CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/cookie")
    static let getCookie:               CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/cookie/\(Attribute.Name.rawValue)")
    static let addCookie:               CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/cookie")
    static let deleteCookie:            CommandType = (HttpMethod.delete, "session/\(Id.Session.rawValue)/cookie/\(Attribute.Name.rawValue)")
    static let deleteAllCookie:         CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/cookie")

    // Timeouts
    static let setTimeout:              CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/timeouts")

    // Actions
    static let actions:                 CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/actions")
    static let releaseActions:          CommandType = (HttpMethod.delete, "session/\(Id.Session.rawValue)/actions")

    // Element Operations
    static let elementClick:            CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/click")
    static let elementTap:              CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/tap")
    static let elementClear:            CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/clear")
    static let elementSendKeys:         CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/value")

    // Alerts
    static let dismissAlert:            CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/alert/dismiss")
    static let acceptAlert:             CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/alert/accept")
    static let getAlertText:            CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/alert/text")
    static let sendAlertText:           CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/alert/text")

    // Screenshot
    static let takeScreenshot:          CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/screenshot")
    static let takeElementScreenshot:   CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/screenshot")

    // Server Extensions
    static let uploadFile:              CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/se/file")


    // For Appium, extend W3C using MJSONWP based commands

    // Session
    static let status:                  CommandType = (HttpMethod.get,    "status")
    static let isElementDisplayed:      CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/element/\(Id.Element.rawValue)/displayed")

    static let getTimeouts:             CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/timeouts")

    static let getCapabilities:         CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)")

    static let getScreenOrientation:    CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/orientation")
    static let setScreenOrientation:    CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/orientation")

    static let getLocation:             CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/location")
    static let setLocation:             CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/location")

    static let imeGetAvailableEngines:  CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/ime/available_engines")
    static let imeGetActiveEngine:      CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/ime/active_engine")
    static let imeIsActivated:          CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/ime/activated")
    static let imeDeactivate:           CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/ime/deactivate")
    static let imeActivateEngine:       CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/ime/activate")

    static let sendKeysToActiveElement: CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/keys")

    static let getAvailableLogTypes:    CommandType = (HttpMethod.get,    "session/\(Id.Session.rawValue)/log/types")
    static let getLog:                  CommandType = (HttpMethod.post,   "session/\(Id.Session.rawValue)/log")
}
