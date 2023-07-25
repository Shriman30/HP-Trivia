//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-25.
//

import SwiftUI

struct Gameplay: View {
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width*3, height: geo.size.height*1.05)
                    .overlay(Rectangle().foregroundColor(.black.opacity(0.8)))
                
                VStack{
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
                    
                    Text("Who is Harry Potter?")
                        .fontDesign(.serif)
                        .font(.system(size:30))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName:"questionmark.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                            .foregroundColor(.cyan)
                            .rotationEffect(.degrees(-20))
                            .padding()
                            .padding(.leading,20)
                        
                        Spacer()
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
                            
                    }
                    .padding(.bottom)
                    
                    LazyVGrid(columns: [GridItem(),GridItem()]) {
                        ForEach(1..<5){ i in
                            Text("Answer \(i)")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .frame(width: geo.size.width/2.15,height:80)
                                .background(.green.opacity(0.45))
                                .cornerRadius(30)
                                
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
        
    }
}

struct Gameplay_Previews: PreviewProvider {
    static var previews: some View {
        Gameplay()
    }
}
