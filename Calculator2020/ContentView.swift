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

    private var firstValue: String = ""
    private var sign: String = ""
    private var secondValue: String = ""
    //@Published var opacity: Double = 1.0
    //@Published var blurRadius: CGFloat = 0.0
    //@Published var imageOrder: Int = 1
    @Published var display: String = ""
    @Published var settingsViewOffset: CGFloat = UIScreen.main.bounds.width / 2
    @Published var isScaled: Bool = false
    @Published var bgImageName: String = "background_image_3"
    
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
    
    private let buttons: [[CalculatorButton]] = [
        [.AC, .minusPlus, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .plus],
        [.one, .two, .three, .minus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        ZStack {
            
            BackgroundImageView(name: self.envObj.bgImageName)
            
            VStack(spacing: 12) {
                
                SettingsButtonView()
                
                Spacer()
                
                DisplayView()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
                
            }.padding(.bottom)
            .scaleEffect(envObj.isScaled ? 0.7 : 1.0)
            .blur(radius: envObj.isScaled ? 7.0 : 0.0)
            .animation(.spring())
            
            SettingsView()
        }
    }
}

struct SettingsButtonView: View {
    
    private var offset: CGFloat = UIScreen.main.bounds.width / 2
    @EnvironmentObject var envObj: GlobalEnvironment
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Button(action: {
                self.envObj.settingsViewOffset -= self.offset
                self.envObj.isScaled.toggle()
                
            }, label: {
                Image("gear_icon")
                    .renderingMode(.original)
            })
            
        }.padding(.all, 20)
    }
}

struct SettingsView: View {
    
    @EnvironmentObject var envObj: GlobalEnvironment
    @State var isDragging = false
    
    private let frameWidth: CGFloat = UIScreen.main.bounds.width / 2
    
    private let bgImages: [String] = [
        "background_image_2",
        "background_image_3",
        "background_image_3",
        "background_image_4"
    ]
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { _ in
                self.isDragging = true
                self.envObj.settingsViewOffset = self.frameWidth
                self.envObj.isScaled = false
        }
            .onEnded { _ in
                self.isDragging = false
        }
    }
    
    var body: some View {
    
        ZStack {
            
            Rectangle()
                .frame(width: self.frameWidth)
                .cornerRadius(15)
                .foregroundColor(Color.init(#colorLiteral(red: 0.8549019694, green: 0.5858128261, blue: 0.719293346, alpha: 0.4600022007)))
            
            VStack(spacing: 20) {
                ForEach(0..<self.bgImages.count) { number in
                    Image(self.bgImages[number])
                        .resizable()
                        .frame(width: self.frameWidth / 2, height: self.frameWidth / 2)
                        .onTapGesture {
                            self.envObj.bgImageName = self.bgImages[number]
                        }
                }
                
            }.padding()

        }
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.envObj.settingsViewOffset + (self.frameWidth / 2), y: 0.0)
        .gesture(self.drag)
        .padding()
        .animation(.spring())
    }
}

struct DisplayView: View {
    
    @EnvironmentObject var envObj: GlobalEnvironment
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Spacer()
            Text(self.envObj.display)
                .font(.system(size: 56))
                .foregroundColor(.white)
                .padding(.trailing, 5)

            // CursorView()
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 70)
        .padding(.trailing)
        .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.1912136884))).cornerRadius(16)
        .animation(nil)
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
            .frame(width: 2, height: 40)
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
        .animation(nil)
    }
    
    private func buttonWidth(_ buttonStyle: CalculatorButton) -> CGFloat {
        if buttonStyle == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct BackgroundImageView: View {
    
    let name: String
    var body: some View {
        
        Image(name)
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
}
