//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Vitaliy on 06.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

enum ButtonStyle: String {
    
    case AC, minusPlus, percent, divide
    case seven, eight, nine, multiple
    case four, five, six, plus
    case one, two, three, minus
    case zero, decimal, equal
    
    var title: String {
        switch self {
        case .AC: return "AC"
        case .minusPlus: return "+-"
        case .percent: return "%"
        case .divide: return "/"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .multiple: return "x"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .plus: return "+"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .minus: return "-"
        case .zero: return "0"
        case .decimal: return "."
        case .equal: return "="
        }
    }
    
    var background: Color {
        switch self {
        case .AC, .minusPlus, .percent:
            return .green
        case .multiple, .divide, .plus, .minus, .equal:
            return .orange
        case .zero, .decimal, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return .gray
        }
    }
}

struct ContentView: View {
    
    @State var firstValue: String = ""
    @State var sign: String = ""
    @State var secondValue: String = ""
    @State var result: String = ""
    
    let buttons: [[ButtonStyle]] = [
        [.AC, .minusPlus, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .plus],
        [.one, .two, .three, .minus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(self.result)
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.clear)
        
                ForEach(buttons, id: \.self) { row in
                    
                    HStack(spacing: 12) {
                        
                        ForEach(row, id: \.self) { button in
                            
                            Button(action: {
                                //self.performComputation(on: button)
                                
                            }, label: {
                                Text(button.title)
                                
                            })
                                .frame(width: self.buttonWidth(button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .background(button.background)
                            .cornerRadius(self.buttonWidth(button) / 2)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    private func buttonWidth(_ buttonStyle: ButtonStyle) -> CGFloat {
        if buttonStyle == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
}

