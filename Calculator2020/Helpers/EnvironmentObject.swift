//
//  EnvironmentObject.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

class GlobalEnvironment: ObservableObject {

    private var firstValue: String = ""
    private var sign: String = ""
    private var secondValue: String = ""
    
    @Published var display: String = ""
    @Published var settingsViewOffset: CGFloat = UIScreen.main.bounds.width / 2
    @Published var isScaled: Bool = false
    @Published var bgImageName: String = "background_image_3"
    @Published var chosenImagePosition: CGFloat = 0.0
    
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

