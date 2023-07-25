//
//  Constants.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-25.
//

import Foundation
import SwiftUI

enum Constants{
    
}

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button{
    func doneButton()->some View{
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(Color("maroon"))
            .foregroundColor(.white)
    }
}
