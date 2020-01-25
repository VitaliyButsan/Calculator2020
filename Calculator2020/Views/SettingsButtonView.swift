//
//  SettingsButtonView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct SettingsButtonView: View {
    
    private var offset: CGFloat = UIScreen.main.bounds.width / 2
    @EnvironmentObject private var envObj: GlobalEnvironment
    
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

