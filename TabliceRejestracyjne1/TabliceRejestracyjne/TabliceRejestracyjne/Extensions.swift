//
//  Extensions.swift
//  TabliceRejestracyjne
//
//  Created by student on 26/03/2024.
//

import Foundation
extension String {
 subscript(_ range: CountableRange<Int>) -> String {
 let start = index(startIndex, offsetBy: max(0, range.lowerBound))
 let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
 return String(self[start..<end])
 }
 subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
 let start = index(startIndex, offsetBy: max(0, range.lowerBound))
 return String(self[start...])
 }
}
