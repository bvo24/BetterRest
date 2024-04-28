//
//  ContentView.swift
//  BetterRest
//
//  Created by Brian Vo on 4/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    
    
    var body: some View {
        Text(Date.now, format: .dateTime.day().month().year())
    }
    func exampleDates(){
//        var component = DateComponents()
//        component.hour = 8
//        component.minute = 0
//        let date = Calendar.current.date(from: component) ?? .now
        
        //Using this helps handle cases like day light saving etc.
        let component =  Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = component.hour ?? 0
        let minute = component.minute ?? 0
        
    }
    
}

#Preview {
    ContentView()
}
