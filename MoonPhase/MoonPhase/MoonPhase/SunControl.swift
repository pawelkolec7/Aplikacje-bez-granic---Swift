//
//  SunControl.swift
//  MoonPhase
//
//  Created by student on 07/05/2024.
//

import SwiftUI

struct SunControl: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Image("sun").resizable().scaledToFit().onAppear() {
                        let frame = geometry.frame(in: .local)
                        height = frame.height
                        width = frame.width
                    }
                }
               
            }
        }
    }
    @State var height:Double = 245.0
    @State var width:Double = 200.0
}

//#Preview {
  //  SunControl()
//}
