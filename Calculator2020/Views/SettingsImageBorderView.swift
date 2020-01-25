//
//  SettingsImageBorderView.swift
//  Calculator2020
//
//  Created by Vitaliy on 25.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct SettingsImageBorderView: View {
    
    let yOffset: CGFloat
    let frameWidth: CGFloat
    
    var body: some View {
        
        Image("empty-frame")
            .resizable()
            .frame(width: self.frameWidth / 2 + 20, height: self.frameWidth / 2 + 20)
            .offset(y: yOffset)

    }
}
