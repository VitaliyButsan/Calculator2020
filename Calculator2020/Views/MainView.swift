//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Vitaliy on 06.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject private var envObj: GlobalEnvironment
    
    private let buttons: [[CalculatorButton]] = [
        [.AC, .minusPlus, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .plus],
        [.one, .two, .three, .minus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        ZStack {
            // 1.0
            BackgroundImageView(name: self.envObj.bgImageName)
            // 2.0
            VStack(spacing: 12) {
                // 2.1
                SettingsButtonView()
                
                Spacer()
                // 2.2
                DisplayView()
                // 2.3
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
            
            // 3.0
            SettingsView()
        }
    }
}
