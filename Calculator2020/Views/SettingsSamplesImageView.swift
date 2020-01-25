//
//  SettingsSampleImageView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct SettingsSamplesImageView: View {
    
    @EnvironmentObject private var envObj: GlobalEnvironment
    @Binding var activeImage: Int
    
    let name: String
    let width: CGFloat
    let index: Int
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Image(self.name)
                .resizable()
                .frame(width: self.width, height: self.width)
                .onTapGesture {
                    let geoFrame = geometry.frame(in: .named("SettingsViewVStack"))
                    self.envObj.chosenImagePosition = geoFrame.origin.y - 90
                    self.activeImage = self.index
                    self.envObj.bgImageName = self.name
                }
        }
    }
}
