//
//  ButtonView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//
import SwiftUI

enum CalculatorButton: String {
    
    case AC, minusPlus, percent, divide
    case seven, eight, nine, multiple
    case four, five, six, plus
    case one, two, three, minus
    case zero, decimal, equal
    
    var title: String {
        switch self {
        case .AC: return "AC"
        case .minusPlus: return "+/-"
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

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    @EnvironmentObject private var envObj: GlobalEnvironment
    
    var body: some View {
        
        Button(action: {
            self.envObj.receiveInput(calculatorButton: self.button)
            
        }, label: {
            Text(button.title).padding()
            
        })
        .frame(width: self.buttonWidth(button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
        .font(.system(size: 32))
        .foregroundColor(.white)
        .background(button.background)
        .cornerRadius(self.buttonWidth(button) / 2)
        .animation(nil)
    }
    
    private func buttonWidth(_ buttonStyle: CalculatorButton) -> CGFloat {
        if buttonStyle == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
