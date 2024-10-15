//
//  MoonControl.swift
//  MoonPhase
//
//  Created by student on 07/05/2024.
//

import SwiftUI

struct MoonControl: View {
    @Binding var hemisphere:Hemisphere
    @Binding var moonPhase: Double
@State var control = 245.0
    init(phase: Binding<Double>, hemisphere: Binding<Hemisphere>) {
        _moonPhase = phase
        _hemisphere = hemisphere
    }
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Image("moon").resizable().scaledToFit().onAppear() {
                        let frame = geometry.frame(in: .local)
                        height = frame.height
                        width = frame.width
                        control = width * 0.62
                    }
                }
                Image("nomoon").resizable().scaledToFit().opacity(0.9).clipShape(
                    DShape(control: controlLowerImage(phase: moonPhase), height: width, width: width)
                )
                Image("moon").resizable().scaledToFit().clipShape(
                    DShape(control: controlUpperImage(phase: moonPhase), height: width, width: width)
                )
            }.rotationEffect(.degrees(hemisphere.rawValue))
        }
    }
    
    
    private func controlUpperImage(phase: Double) -> Double {
        var ret = 0.0
        if phase <= 50 {
            ret = -control
        } else {
            ret = control-control*(phase-50)/25
        }
        return ret
    }
    private func controlLowerImage(phase: Double) -> Double {
        var ret = 0.0
        if phase <= 50 {
            ret = control-(phase)*control/25
        } else {
            ret = control
        }
        return ret
    }
    @State var height:Double = 245.0
    @State var width:Double = 200.0
}
struct DShape: Shape {
    private var control = 245
    private var maxY = 380
    private var maxX = 200
    
    init(control: Double, height: Double, width: Double) {
        self.control = Int(control)
        self.maxY = Int(height)
        self.maxX = Int(width)
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x:maxX/2,y:0))
            path.addCurve(
                to: CGPoint(x: maxX/2, y: maxY),
                control1: CGPoint(x: control+maxX/2, y: 0),
                control2: CGPoint(x: control+maxX/2, y: maxY))
            path.addLine(to: CGPoint(x:0,y:maxY))
            path.addLine(to: .zero)
            path.closeSubpath()
        }
    }
}


//#Preview {
  //  MoonControl()
//}
