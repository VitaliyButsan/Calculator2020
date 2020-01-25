//
//  DisplayView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct DisplayView: View {
    
    @EnvironmentObject private var envObj: GlobalEnvironment
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Spacer()
            
            Text(self.envObj.display)
                .font(.system(size: 56))
                .foregroundColor(.white)
                .padding(.trailing, 5)

        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 70)
        .padding(.trailing)
        .background(Color.init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.1912136884))).cornerRadius(16)
        .animation(nil)
    }
}

