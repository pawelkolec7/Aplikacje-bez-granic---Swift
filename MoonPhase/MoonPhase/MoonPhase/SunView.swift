//
//  SunView.swift
//  MoonPhase
//
//  Created by student on 07/05/2024.
//

import SwiftUI
import CoreLocation
import SwiftAA
struct SunView: View {
    @State var sunPhase: Double = 75
    @State var date = Date()
    @State var sunRise = Date()
    @State var sunSet = Date()
    @State var sunRiseTime = Date()
    @State var transit = Date()
    @State var dayLength = " "
    
    @Binding var location : CLLocationCoordinate2D
    init(location: Binding<CLLocationCoordinate2D>) {
        _location = location
    }
    
    func calculatePhase() {
        let jd=JulianDay(date) //Konwersja na JulianDay
        let coordinates = GeographicCoordinates(CLLocation(location)!)
        let sun = Sun(julianDay: jd).riseTransitSetTimes(for: coordinates)
        if let sunrise = sun.riseTime?.date{
            sunRise=sunrise
        }
        if let sunset = sun.setTime?.date{
            sunSet=sunset
        }
        if let transit_ = sun.transitTime?.date{
            transit=transit_
        }
        let delta = sunSet.timeIntervalSince(sunRise)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        dayLength = formatter.string(from: delta) ?? "00:00.00"
    }
    var body: some View {
        VStack {
            HStack {
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Select date")
                }
                Spacer()
                Button("Today") {
                    date = Date()
                }
            }
            Spacer()
            SunControl()
            Spacer()
            HStack {
                Text("Sunrise")
                Spacer()
                Text(sunRise.timeOnly)
            }
            HStack {
                Text("Transit")
                Spacer()
                Text(transit.timeOnly)
            }
            HStack {
                Text("Sunset")
                Spacer()
                Text(sunSet.timeOnly)
            }.onAppear() {
                calculatePhase()
            }
            HStack {
                Text("Day length")
                Spacer()
                Text(dayLength)
            }.onChange(of: date) {oldDate, newDate in
                calculatePhase()
            }
        }
    }
}

//#Preview {
  //  SunView()
//}
