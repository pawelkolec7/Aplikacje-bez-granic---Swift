//
//  ClearableTextField.swift
//  AsystentPPK
//
//  Created by student on 21/05/2024.
//

import Foundation
import SwiftUI
struct ClearableTextField: View {
    var title: String
    @Binding var value: Double
    @State private var text: String
    @FocusState private var focused: Bool
    init(_ title: String, value: Binding<Double>) {
        self.title = title
        _value = value
        var s = value.wrappedValue.format(decimalPlaces: 2)
        if value.wrappedValue == 0 {
            s = ""
        }
        _text = State(initialValue: s)
    }
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(title, text: $text).focused($focused)
                .textFieldStyle(.roundedBorder).keyboardType(.decimalPad)
                .onChange(of: text) {
                    value = text.toDouble() ?? 0.0
                }
            if focused {
                if text != "" {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            text = ""
                        }
                }
            }
        }
    }
}
