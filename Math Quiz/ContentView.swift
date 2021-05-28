//
//  ContentView.swift
//  Math Quiz
//
//  Created by Alexander Bonney on 5/7/21.
//

import SwiftUI



struct ContentView: View {

    
    @State private var number = Int.random(in: 0...12)
    @State private var picker = 1
    
    @State private var answer = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var questionAmountPicker = 1
    let questionAmountValues = [10, 15, 20, 25, 30]
    
    @State private var questionCount = 0
    @State private var correctAnswerCount = 0
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose the table you want", selection: $picker) {
                        ForEach(0..<13) { number in
                            Text("\(number)")
                        }
                    }
                }
                
                Section(header: Text("How many questions do you want?")) {
                    Picker(selection: $questionAmountPicker, label: Text("Picker"), content: {
                        ForEach(0..<questionAmountValues.count) {
                            Text("\(questionAmountValues[$0])")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Quiz")) {
                    Text("\(number) * \(picker) = ")
                    TextField("type your answer here", text: $answer, onCommit: {
                        checkAnswer()
                    })
                        .keyboardType(.numberPad)
                    Button("Confirm answer") {
                        checkAnswer()
                    }
                }

            }
            .navigationBarTitle("Multiplication Quiz")
        }.alert(isPresented: $showingAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                withAnimation(.easeIn) {
                    refresh()
                }
            })
        })
    }
    
    
    
    func refresh() {
        number = Int.random(in: 0...12)
        answer = ""
        if questionCount == questionAmountValues[questionAmountPicker] {
            questionCount = 0
            correctAnswerCount = 0
            picker = Int.random(in: 0...12)

        }
    }
    
    func checkAnswer() {
        //when person answers the question, question count becomes 1 more
        questionCount += 1
        //gettin integer from String
        let answer = Int(answer) ?? 0
        //check right answer
        if answer == number * picker {
            correctAnswerCount += 1
            alertTitle = "Correct"
            if questionCount == questionAmountValues[questionAmountPicker] {
                alertTitle = "You finished!"
            }
        } else {
            alertTitle = "Incorrect"
        }
        alertMessage = "question \(questionCount)/\(questionAmountValues[questionAmountPicker]), right ones: \(correctAnswerCount)/\(questionAmountValues[questionAmountPicker])"
        showingAlert = true
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
