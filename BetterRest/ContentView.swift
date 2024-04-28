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
        //Displaying only hours and minutes
        //DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
        //Limits on date
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
            .labelsHidden()
        
    }
    func exampleDates(){
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
    
}

#Preview {
    ContentView()
}
