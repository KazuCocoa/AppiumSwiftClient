//
//  error.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//
public enum WebDriverErrorEnum: Error {
    // TODO: will change
    public typealias Error = [String: String]

    case WebDriverError(error: Error) // standard

    case IndexOutOfBoundsError // 1
    case NoCollectionError // 2
    case NoStringError // 3
    case NoStringLengthError // 4
    case NoStringWrapperError // 5
    case NoSuchDriverError // 6

    // An element could not be located on the page using the given search parameters.
    // # example
    // ["value": {
    //                error = "no such element";
    //                message = "An element could not be located on the page using the given search parameters.";
    //                stacktrace = "NoSuchElementError: An element could not be located on the page using the given search parameters.\n    at XCUITestDriver.<anonymous> (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/lib/commands/find.js:130:13)\n    at Generator.throw (<anonymous>)\n    at asyncGeneratorStep (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:3:24)\n    at _throw (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:29:9)\n    at <anonymous>";
    //                }]
    case NoSuchElementError(error: Error) // 7

    // A command to switch to a frame could not be satisfied because the frame could not be found.
    case NoSuchFrameError // 8

    // A command could not be executed because the remote end is not aware of it.
    case UnknownCommandError // 9

    // A command failed because the referenced element is no longer attached to the DOM.
    case StaleElementReferenceError // 10

    // Raised to indicate that although an element is present on the DOM, it is not visible, and
    // so is not able to be interacted with.
    case ElementNotVisibleError // 11

    // The target element is in an invalid state, rendering it impossible to interact with, for
    // example if you click a disabled element.
    case InvalidElementStateError // 12

    // An unknown error occurred in the remote end while processing the command.
    case UnknownError // 13
    case ExpectedError // 14

    // An attempt was made to select an element that cannot be selected.
    case ElementNotSelectableError // 15
    case NoSuchDocumentError // 16

    // An error occurred while executing JavaScript supplied by the user.
    case JavascriptError // 17
    case NoScriptResultError // 18

    // An error occurred while searching for an element by XPath.
    case XPathLookupError // 19
    case NoSuchCollectionError // 20

    // An operation did not complete before its timeout expired.
    case TimeOutError // 21

    case NullPointerError // 22
    case NoSuchWindowError // 23

    // An illegal attempt was made to set a cookie under a different domain than the current page.
    case InvalidCookieDomainError // 24

    // A command to set a cookie's value could not be satisfied.
    case UnableToSetCookieError // 25

    // Raised when an alert dialog is present that has not been dealt with.
    case UnhandledAlertError // 26

    // An attempt was made to operate on a modal dialog when one was not open:
    //   * W3C dialect is NoSuchAlertError
    //   * OSS dialect is NoAlertPresentError
    // We want to allow clients to rescue NoSuchAlertError as a superclass for
    // dialect-agnostic implementation, so NoAlertPresentError should inherit from it.
    case NoSuchAlertError
    case NoAlertPresentError // 27, OSS

    // A script did not complete before its timeout expired.
    case ScriptTimeOutError // 28

    // The coordinates provided to an interactions operation are invalid.
    case InvalidElementCoordinatesError // 29

    // Indicates that IME support is not available. This exception is rasied for every IME-related
    // method call if IME support is not available on the machine.
    case IMENotAvailableError // 30

    // Indicates that activating an IME engine has failed.
    case IMEEngineActivationFailedError // 31

    // Argument was an invalid selector.
    case InvalidSelectorError // 32

    // A new session could not be created.
    case SessionNotCreatedError(error: Error) // 33

    // The target for mouse interaction is not in the browser's viewport and cannot be brought
    // into that viewport.
    case MoveTargetOutOfBoundsError // 34

    // Indicates that the XPath selector is invalid
    case InvalidXpathSelectorError
    case InvalidXpathSelectorReturnTyperError

    // A command could not be completed because the element is not pointer or keyboard
    // interactable.
    case ElementNotInteractableError

    // The arguments passed to a command are either invalid or malformed.
    case InvalidArgumentError

    // No cookie matching the given path name was found amongst the associated cookies of the
    // current browsing context's active document.
    case NoSuchCookieError

    // A screen capture was made impossible.
    case UnableToCaptureScreenError

    // Occurs if the given session id is not in the list of active sessions, meaning the session
    // either does not exist or that it's not active.
    case InvalidSessionIdError(error: Error)

    // A modal dialog was open, blocking this operation.
    case UnexpectedAlertOpenError

    // The requested command matched a known URL but did not match an method for that URL.
    case UnknownMethodError

    // The Element Click command could not be completed because the element receiving the events
    // is obscuring the element that was requested clicked.
    case ElementClickInterceptedError

    // Indicates that a command that should have executed properly cannot be supported for some
    // reason.
    case UnsupportedOperationError
}
