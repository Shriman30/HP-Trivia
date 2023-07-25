//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-25.
//

import SwiftUI

struct Gameplay: View {
    @State private var animateViewIn = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width*3, height: geo.size.height*1.05)
                    .overlay(Rectangle().foregroundColor(.black.opacity(0.8)))
                
                VStack{
                    //MARK: Controls
                    HStack{
                        Button("End Game"){
                            //TODO: End game
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        Text("Score: 33")
                    }
                    .padding()
                    .padding(.vertical,30)
                    
                    //MARK: Questions
                    VStack{
                        if animateViewIn {
                            Text("Who is Harry Potter?")
                                .fontDesign(.serif)
                                .font(.system(size:30))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                        }
                    }
                    .animation(.easeInOut(duration:2),value:animateViewIn)
                    
                    Spacer()
                    
                    // MARK: Hints
                    HStack{
                        VStack{
                            if animateViewIn  {
                                Image(systemName:"questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100)
                                    .foregroundColor(.cyan)
                                    .rotationEffect(.degrees(-20))
                                    .padding()
                                    .padding(.leading,20)
                                    .transition(.offset(x:-geo.size.width/2)) // transition left to right
                            }
                            
                        }
                        .animation(.easeOut(duration:0.7).delay(2), value: animateViewIn)
                        
                        Spacer()
                        VStack{
                            if animateViewIn{
                                Image(systemName:"book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .cornerRadius(20)
                                    .rotationEffect(.degrees(20))
                                    .padding()
                                    .padding(.trailing,20)
                                    .transition(.offset(x:geo.size.width/2)) // transition right to left
                                
                            }
                        }.animation(.easeOut(duration:0.7).delay(2),value:animateViewIn)
                        
                        
                    }
                    .padding(.bottom)
                    
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(),GridItem()]) {
                        ForEach(1..<5){ i in
                            VStack{
                                if animateViewIn{
                                    Text("Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width/2.15,height:80)
                                        .background(.green.opacity(0.45))
                                        .cornerRadius(30)
                                        .transition(.scale)
                                }
                            }.animation(.easeOut(duration:1).delay(1.5), value: animateViewIn)
                        }
                    }
                    Spacer()
                }
                .frame(width:geo.size.width, height:geo.size.height)
                .foregroundColor(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear{
            animateViewIn = true
        }
    }
}

struct Gameplay_Previews: PreviewProvider {
    static var previews: some View {
        Gameplay()
    }
}
