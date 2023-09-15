//
//  File.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by sudeep rai on 11/06/22.
//

import Foundation
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
    var htmlToAttributedString: NSAttributedString? {
           guard let data = data(using: .utf8) else { return nil }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
           } catch {
               return nil
           }
       }
       var htmlToString: String {
           return htmlToAttributedString?.string ?? ""
       }
    
    
    func hexString() -> String {
        return self.data(using: .utf8)!.hexString()
    }
    
    func SHA1() -> String {
        return self.data(using: .utf8)!.SHA1().hexString()
    }
    func slice(from: String, to: String) -> String? {

           return (range(of: from)?.upperBound).flatMap { substringFrom in
               (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                   String(self[substringFrom..<substringTo])
               }
           }
       }
    func matches(_ regex: String) -> Bool {
           return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
       }
    func base64Encoded() -> String? {
           return data(using: .utf8)?.base64EncodedString()
       }

       func base64Decoded() -> String? {
           guard let data = Data(base64Encoded: self) else { return nil }
           return String(data: data, encoding: .utf8)
       }
    func contains(_ strings: [String]) -> Bool {
            strings.contains { contains($0) }
        }
}
