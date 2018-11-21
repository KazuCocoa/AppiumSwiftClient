//
//  error.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/13.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//
public enum WebDriverErrorEnum: Error {
    case webDriverError(error: WebDriverError.W3C) // standard

    case indexOutOfBoundsError // 1
    case noCollectionError // 2
    case noStringError // 3
    case noStringLengthError // 4
    case noStringWrapperError // 5
    case noSuchDriverError // 6

    // swiftlint:disable line_length
    // An element could not be located on the page using the given search parameters.
    // # example
    // ["value": {
    //                error = "no such element";
    //                message = "An element could not be located on the page using the given search parameters.";
    //                stacktrace = "NoSuchElementError: An element could not be located on the page using the given search parameters.\n
    //    at XCUITestDriver.<anonymous> (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/lib/commands/find.js:130:13)\n
    //    at Generator.throw (<anonymous>)\n
    //    at asyncGeneratorStep (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:3:24)\n
    //    at _throw (/Users/kazuaki/GitHub/appium/node_modules/appium-xcuitest-driver/node_modules/@babel/runtime/helpers/asyncToGenerator.js:29:9)\n
    //    at <anonymous>";
    //                }]
    case noSuchElementError(error: WebDriverError.W3C) // 7

    // A command to switch to a frame could not be satisfied because the frame could not be found.
    case noSuchFrameError // 8

    // A command could not be executed because the remote end is not aware of it.
    case unknownCommandError // 9

    // A command failed because the referenced element is no longer attached to the DOM.
    case staleElementReferenceError // 10

    // Raised to indicate that although an element is present on the DOM, it is not visible, and
    // so is not able to be interacted with.
    case elementNotVisibleError // 11

    // The target element is in an invalid state, rendering it impossible to interact with, for
    // example if you click a disabled element.
    case invalidElementStateError // 12

    // An unknown error occurred in the remote end while processing the command.
    case unknownError // 13
    case expectedError // 14

    // An attempt was made to select an element that cannot be selected.
    case elementNotSelectableError // 15
    case noSuchDocumentError // 16

    // An error occurred while executing JavaScript supplied by the user.
    case javascriptError // 17
    case noScriptResultError // 18

    // An error occurred while searching for an element by XPath.
    case xPathLookupError // 19
    case noSuchCollectionError // 20

    // An operation did not complete before its timeout expired.
    case timeOutError // 21

    case nullPointerError // 22
    case noSuchWindowError // 23

    // An illegal attempt was made to set a cookie under a different domain than the current page.
    case invalidCookieDomainError // 24

    // A command to set a cookie's value could not be satisfied.
    case unableToSetCookieError // 25

    // Raised when an alert dialog is present that has not been dealt with.
    case unhandledAlertError // 26

    // An attempt was made to operate on a modal dialog when one was not open:
    //   * W3C dialect is NoSuchAlertError
    //   * OSS dialect is NoAlertPresentError
    // We want to allow clients to rescue NoSuchAlertError as a superclass for
    // dialect-agnostic implementation, so NoAlertPresentError should inherit from it.
    case noSuchAlertError
    case noAlertPresentError // 27, OSS

    // A script did not complete before its timeout expired.
    case scriptTimeOutError // 28

    // The coordinates provided to an interactions operation are invalid.
    case invalidElementCoordinatesError // 29

    // Indicates that IME support is not available. This exception is rasied for every IME-related
    // method call if IME support is not available on the machine.
    case iMENotAvailableError // 30

    // Indicates that activating an IME engine has failed.
    case iMEEngineActivationFailedError // 31

    // Argument was an invalid selector.
    case invalidSelectorError // 32

    // A new session could not be created.
    case sessionNotCreatedError(error: WebDriverError.W3C) // 33

    // The target for mouse interaction is not in the browser's viewport and cannot be brought
    // into that viewport.
    case moveTargetOutOfBoundsError // 34

    // Indicates that the XPath selector is invalid
    case invalidXpathSelectorError
    case invalidXpathSelectorReturnTyperError

    // A command could not be completed because the element is not pointer or keyboard
    // interactable.
    case elementNotInteractableError

    // The arguments passed to a command are either invalid or malformed.
    case invalidArgumentError

    // No cookie matching the given path name was found amongst the associated cookies of the
    // current browsing context's active document.
    case noSuchCookieError

    // A screen capture was made impossible.
    case unableToCaptureScreenError

    // Occurs if the given session id is not in the list of active sessions, meaning the session
    // either does not exist or that it's not active.
    case invalidSessionIdError(error: WebDriverError.W3C)

    // A modal dialog was open, blocking this operation.
    case unexpectedAlertOpenError

    // The requested command matched a known URL but did not match an method for that URL.
    case unknownMethodError

    // The Element Click command could not be completed because the element receiving the events
    // is obscuring the element that was requested clicked.
    case elementClickInterceptedError

    // Indicates that a command that should have executed properly cannot be supported for some
    // reason.
    case unsupportedOperationError
}
