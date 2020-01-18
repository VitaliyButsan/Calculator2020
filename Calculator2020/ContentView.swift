//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Vitaliy on 06.01.2020.
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

class GlobalEnvironment: ObservableObject {

    var firstValue: String = ""
    var sign: String = ""
    var secondValue: String = ""
    @Published var opacity: Double = 1.0
    @Published var blurRadius: CGFloat = 0.0
    @Published var imageOrder: Int = 1
    @Published var display: String = ""
    
    func receiveInput(calculatorButton: CalculatorButton) {
        self.performCalculation(with: calculatorButton)
    }
    
    private func performCalculation(with button: CalculatorButton) {
        
        switch button {
            
        case .AC:
            self.firstValue.removeAll()
            self.secondValue.removeAll()
            self.sign.removeAll()
            self.display.removeAll()
            
        //=======================================================================
          /*
        case .seven:
            self.imageOrder -= 1
            self.display = String(self.imageOrder)
        case .eight:
            self.imageOrder += 1
            self.display = String(self.imageOrder)
        case .four:
            self.blurRadius -= 1
            self.display = String(Double(self.blurRadius))
        case .five:
            self.blurRadius += 1
            self.display = String(Double(self.blurRadius))
        case .one:
            self.opacity -= 0.1
            self.display = String(self.opacity)
        case .two:
            self.opacity += 0.1
            self.display = String(self.opacity)
        // ======================================================================
            */
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if sign.isEmpty {
                self.firstValue += button.title
                self.display = self.firstValue
            } else {
                self.secondValue += button.title
                self.display = self.secondValue
            }
            
        case .divide, .multiple, .minus, .plus:
            self.sign = button.title
            self.display = self.sign
            
        case .decimal:
            if self.sign.isEmpty, !self.firstValue.contains(".") {
                self.firstValue += button.title
                self.display = self.firstValue
            } else if !self.sign.isEmpty, !self.secondValue.contains(".") {
                self.secondValue += button.title
                self.display = self.secondValue
            }
            
        case .equal:
            if !self.firstValue.isEmpty, !self.secondValue.isEmpty {
                
                switch sign {
                case "+":
                    self.display = String(Double(self.firstValue)! + Double(self.secondValue)!)
                case "-":
                    self.display = String(Double(self.firstValue)! - Double(self.secondValue)!)
                case "/":
                    self.display = String(Double(self.firstValue)! / Double(self.secondValue)!)
                case "*":
                    self.display = String(Double(self.firstValue)! * Double(self.secondValue)!)
                default:
                    break
                }
            }

        default:
            break
        }
    }
}

struct ContentView: View {

    @EnvironmentObject var envObj: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.AC, .minusPlus, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .plus],
        [.one, .two, .three, .minus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Image("4")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                DisplayView()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct DisplayView: View {
    
    @EnvironmentObject var envObj: GlobalEnvironment
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Spacer()
            Text(self.envObj.display)
                .font(.system(size: 58))
                .foregroundColor(.white)
                .padding(.trailing, 5)

            CursorView()
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 70)
        .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.1912136884))).cornerRadius(16)
    }
}

struct CursorView: View {
    
    @State var opacityPercent: Double = 0.0
    
    var repeatingAnimation: Animation {
        Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: 2, height: 45)
            .padding(.trailing)
            .opacity(opacityPercent)
            .onAppear() {
                withAnimation(self.repeatingAnimation) { self.opacityPercent = 0.5 }
        }
    }
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var envObj: GlobalEnvironment
    
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
    }
    
    private func buttonWidth(_ buttonStyle: CalculatorButton) -> CGFloat {
        if buttonStyle == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
