//
//  SettingsView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var envObj: GlobalEnvironment
    @State private var isDragging = false
    @State private var activeIndex: Int = 0
    
    private let frameWidth: CGFloat = UIScreen.main.bounds.width / 2

    private let bgImages: [String] = [
        "background_image_1",
        "background_image_2",
        "background_image_3",
        "background_image_4"
    ]
   
    private var defaultEmptyFrameOffset: CGFloat = -165.0
    
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
            
            VStack() {
                ForEach(0..<self.bgImages.count) { index in
                    SettingsSamplesImageView(activeImage: self.$activeIndex, name: self.bgImages[index], width: self.frameWidth / 2, index: index)
                }
            }
            .padding([.bottom, .top], 90)
            .coordinateSpace(name: "SettingsViewVStack")
            
            SettingsImageBorderView(yOffset: self.defaultEmptyFrameOffset + self.envObj.chosenImagePosition, frameWidth: self.frameWidth)
        }
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.envObj.settingsViewOffset + (self.frameWidth / 2))
        .gesture(self.drag)
        .padding()
        .animation(.spring())
    }
}
