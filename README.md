**This is completely experimental library**

![Swift](https://github.com/KazuCocoa/AppiumSwiftClient/workflows/Swift/badge.svg?branch=master)

# About this library

Currently, Appium support Java, Ruby, Python, JavaScript and C# clients mainly.
Not so active, but Perl and PHP are also available.

In the Web world, it is worth to develop test code following their developing languages.
In the Mobile world, we have few selections for it since Android requires Java/Kotlin and iOS requires Objective-C/Swift. (Of course, Windows stuff are C#)

Appium is written in JavaScript, especially NodeJS. Some popular support libraries such as Danger and Cocoapods are written in Ruby. Machine Learning stuff is Python.

(notice)
I understand Google and Apple maintain Espresso for Android and XCUITest for iOS as their official automation tools. I have much experience in such frameworks as well. Sometimes they strongly depend on their internal code of the production layer than Appium tests. (And it requires specialised built apk)

It's trade-off thing, but I thought if we have Swift client for iOS, it also helps Test/QA/development world.

This repository has not been stable yet. Has no concrete roadmap. But let me try to prototype the client in Swift.

# how to try out

- `git clone`
- Run `AppiumFuncTests` scheme as test
    - Write scenarios in https://github.com/KazuCocoa/AppiumSwiftClient/tree/master/AppiumFuncTests

# W3C

- https://w3c.github.io/webdriver/

# Notice

- This might happen breaking changes

:# Reference
- In Appium repo, we already have selenium-swift. But the library stops maintaining
    - https://github.com/appium/selenium-swift

# License
Apache License 2.0

