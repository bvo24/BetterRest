//
//  ContentView.swift
//  BetterRest
//
//  Created by Brian Vo on 4/28/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmmount = 8.0
    @State private var coffeeAmmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                VStack(alignment: .leading, spacing: 0){
                    
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("Desired ammount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmmount.formatted()) hours", value: $sleepAmmount, in: 4...12, step: 0.25 )
                    }
                    VStack(alignment: .leading, spacing: 0){
                        Text("Daily coffee intake")
                            .font(.headline)
                        //Short cut for handling singular / plural
                        //                    Stepper("^[\(coffeeAmmount) cup](inflect: true)", value: $coffeeAmmount, in: 0...20)
                        Picker("Cups of cofee", selection: $coffeeAmmount){
                            ForEach(0..<21){
                                Text("\($0)")
                            }
                        }
                    }
                    
                    
                }
                Section(header: Text("Reccomended bed time").font(.headline)){
                    
                    Text("\(calculateBedString())")
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button("Calculate", action: calculateBedTime)
//            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("Okie"){}
                
            }message: {
                Text(alertMessage)
            }
            
            
            
            
            
        }
        

        
        
        
        
        
    }
    
    
    //for button
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = ( components.minute ?? 0 ) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmmount, coffee: Double(coffeeAmmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Ideal bed time is "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }
        catch{
            alertTitle = "ERROR"
            alertMessage = "Problem finding bed time"
            
            
        }
        showingAlert = true
        
    }
    
    func calculateBedString() -> String{
        let userMsg : String
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = ( components.minute ?? 0 ) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmmount, coffee: Double(coffeeAmmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            //alertTitle = "Ideal bed time is "
            let formatter = DateFormatter()
            formatter.timeStyle = .short
                        
            userMsg = formatter.string(from: sleepTime)
            
        }
        catch{
            userMsg = "Error"
            
            
        }
        return userMsg
        
    }
    
    
    

    
    
    
}



#Preview {
    ContentView()
}
