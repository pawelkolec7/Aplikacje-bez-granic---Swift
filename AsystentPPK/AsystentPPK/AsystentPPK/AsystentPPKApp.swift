//
//  AsystentPPKApp.swift
//  AsystentPPK
//
//  Created by student on 21/05/2024.	
//

import SwiftUI
import SwiftData

@main
struct AsystentPPKApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Deposit.self)
    }
}
