//
//  DebugLoggingService.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import Foundation
import UIKit

enum DebugLogType: String {
    /// Pending implementation
    case todo
    /// General information, e.g., lifecycle method calls
    case info
    /// For Swift-side errors or problems
    case error
    /// For API/Server-side problems, e.g, unexpected response
    case warning
    /// For successful API calls
    case success
    /// For failed API calls
    case failure
    
    var symbol: String {
        switch self {
        case .todo: return "🚧"
        case .info: return "🔵"
        case .error: return "⛔️"
        case .warning: return "⚠️"
        case .success: return "✅"
        case .failure: return "❌"
        }
    }
}

class DebugLoggingService {
    private init() { }
    
    class func log(status: DebugLogType,
                   message: String = "",
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
        
        var logText = ""
        
        let fileName =
            file.components(separatedBy: "/")
            .last?
            .replacingOccurrences(of: ".swift", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        logText = "\(dateFormatter.string(from: Date())) \(status.symbol) \(status.rawValue.uppercased()) \(fileName ?? file).\(function):\(line)"
        
        logText.append(message.isEmpty ? "" : " - \(message)")
        
        #if DEBUG
        print(logText)
        #endif
    }
}
