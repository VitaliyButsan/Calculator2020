//
//  BackgroundView.swift
//  Calculator2020
//
//  Created by Vitaliy on 24.01.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import SwiftUI

struct BackgroundImageView: View {
    
    let name: String
    
    var body: some View {
        
        Image(name)
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
}

