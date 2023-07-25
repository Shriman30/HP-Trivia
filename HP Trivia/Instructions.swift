//
//  Instructions.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-25.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            //background
            InfoBackgroundImage()
            //Content
            VStack{
                // logo
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150)
                    .padding(.top)
                
                ScrollView{
                    //Instructions
                    Text("⚡️How to Play⚡️")
                        .font(.largeTitle)
                        .padding()
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        Text("      Welcome to the Harry Potter Trivia! Test your knowledge from the books! If you guess the answers right, you will get points! Guess them wrong, and you will lose points.🪄 ")
                            .padding([.horizontal,.bottom])
                        
                        
                        
                        
                        Text("Getting each question right will grant you 5 points. However, each wrongful attempt at answering a question will deduct a point.")
                            .padding([.horizontal,.bottom])
                        
                        
                        Text("You may find yourself struggling to answer a few questions. Rest assured you are given the option to reveal a hint or reveal the book that answers the question. But beware! Using these also minuses 1 point each.")
                            .padding([.horizontal,.bottom])
                        
                        
                        Text("Selecting the correct answer will grant you all the points left for that question. These points will be added to the total score.")
                            .padding([.horizontal,.bottom])
                    }
                    
                    Text("Good luck!🧙‍♂️")
                        .font(.title)
                        .padding(.top,5)
                }
                .fontDesign(.serif)
                .foregroundColor(.black)
                
                // Button to dismiss view
                Button("Done"){
                    dismiss()
                }.doneButton()

            }
        }
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
