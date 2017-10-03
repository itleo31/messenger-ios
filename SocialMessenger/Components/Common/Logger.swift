//
//  Logger.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/20/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LoggerManager: NSObject {
    static let shared = LoggerManager()
    
    private override init() { }
    
    func configure() {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
    }
    
    let logger: Logger = CocoaLumberjackLogger()
}

protocol Logger: NSObjectProtocol {
    func logDebug(_ message: @autoclosure () -> String)
    
    func logError(_ message: @autoclosure () -> String)
    
    func logInfo(_ message: @autoclosure () -> String)
    
    func logVerbose(_ message: @autoclosure () -> String)
    
    func logWarn(_ message: @autoclosure () -> String)
}

class CocoaLumberjackLogger: NSObject, Logger {
    func logDebug(_ message: @autoclosure () -> String) {
        DDLogDebug(message)
    }
    
    func logError(_ message: @autoclosure () -> String) {
        DDLogError(message)
    }
    
    func logInfo(_ message: @autoclosure () -> String) {
        DDLogInfo(message)
    }
    
    func logVerbose(_ message: @autoclosure () -> String) {
        DDLogVerbose(message)
    }
    
    func logWarn(_ message: @autoclosure () -> String) {
        DDLogWarn(message)
    }
}

// MARK: - Convenient methods

public func logDebug(_ message: @autoclosure () -> String) {
    LoggerManager.shared.logger.logDebug(message)
}

public func logError(_ message: @autoclosure () -> String) {
    LoggerManager.shared.logger.logError(message)
}

public func logInfo(_ message: @autoclosure () -> String) {
    LoggerManager.shared.logger.logInfo(message)
}

public func logVerbose(_ message: @autoclosure () -> String) {
    LoggerManager.shared.logger.logVerbose(message)
}

public func logWarn(_ message: @autoclosure () -> String) {
    LoggerManager.shared.logger.logWarn(message)
}
