//
//  Utils.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/19/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import UIKit

func delay(_ interval: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval, execute: execute)
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

private let whitespaces = CharacterSet.whitespacesAndNewlines


protocol StringWrapper {
    var asString: String { get }
}

extension Optional where Wrapped: StringWrapper {
    
    var notEmptyValue: String? {
        switch self {
        case .some(let wrapped):
            return wrapped.asString.isEmpty ? nil : wrapped.asString
        default:
            return nil
        }
    }
    
    var trimmed: String {
        switch self {
        case .some(let wrapped):
            return wrapped.asString.trimWhitespaces()
        default:
            return ""
        }
    }
    
    var toEmptyIfNil: String {
        switch self {
        case .some(let wrapped):
            return wrapped.asString
        default:
            return ""
        }
    }
}


extension String: StringWrapper {
    var asString: String { return self }
}


/// Extension on Options with constraint to collection type
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        guard let value = self else { return true }
        return value.isEmpty
    }
    
    var hasElements: Bool {
        return !isNilOrEmpty
    }
}

public extension String {
    
    /// Removes whitespaces from both ends of the string.
    public func trimWhitespaces() -> String {
        return self.trimmingCharacters(in: whitespaces)
    }
    
    /// A new string made by deleting the extension
    /// (if any, and only the last) from the receiver.
    public var stringByDeletingPathExtension: String {
        let string: NSString = self as NSString
        return string.deletingPathExtension
    }
    
    /// The last path component.
    /// This property contains the last path component. For example:
    ///
    /// 	 /tmp/scratch.tiff ➞ scratch.tiff
    /// 	 /tmp/scratch ➞ scratch
    /// 	 /tmp/ ➞ tmp
    ///
    public var lastPathComponent: String {
        let string: NSString = self as NSString
        return string.lastPathComponent
    }
    
}

// MARK: - Regular Expressions

/// *Regex* creation syntax sugar (with no error handling).
///
/// For a quick guide, see:
/// * [NSRegularExpression Cheat Sheet and Quick Reference](http://goo.gl/5QzdhX)
public func regex(_ pattern: String, options: NSRegularExpression.Options = [ ])
    -> NSRegularExpression {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex
}

/// Useful extensions for NSRegularExpression objects.
public extension NSRegularExpression {
    
    /// Returns `true` if the specified string is fully matched by this regex.
    public func matchesString(_ string: String) -> Bool {
        // Ranges are based on the UTF-16 *encoding*.
        let length = string.utf16.count
        precondition(length == (string as NSString).length)
        
        let wholeString = NSRange(location: 0, length: length)
        let matches = numberOfMatches(in: string, options: [ ], range: wholeString)
        return matches == 1
    }
}

func isIOS10Available() -> Bool {
    if #available(iOS 10.0, *) {
        return true
    } else {
        return false
    }
}
