//
//  Deposit.swift
//  AsystentPPK
//
//  Created by student on 21/05/2024.
//

import Foundation
import SwiftData

enum Source: Int,Codable,CaseIterable {
    case employee = 1
    case employer = 2
    case government = 3
    case none = 0
    
    var asString: String {
        get {
            switch self {
            case .none:
                return ""
            case .employee:
                return "Pracownik"
            case .employer:
                return "Pracodawca"
            case .government:
                return "Państwo"
            }
        }
    }
}

@Model class Deposit {
    var source: Source
    var amount: Double
    var unitValue: Double
    var date: Date
    
    init(source: Source = .none, amount: Double, unitValue: Double, date: Date = Date()) {
        self.source = source
        self.amount = amount
        self.unitValue = unitValue
        self.date = date
    }
    
    var units: Double {
        get {
            let unitPrice = Double(truncating: self.unitValue as NSNumber)
            let amountValue = Double(truncating: self.amount as NSNumber)
            let un = amountValue / unitPrice
            return un
        }
    }
}
