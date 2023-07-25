//
//  ContentView.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewIn = false
    
    @State private var audioPlayer:AVAudioPlayer!
    @State private var showInstructionScreen = false
    @State private var showSettingsScreen = false
    @State private var playGame = false
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                //Background Image
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width*3, height: geo.size.height)
                    .padding(.top,3)
                //animation effect: translate left to right then right to left
                    .offset(x: moveBackgroundImage ? geo.size.width/1.1 : -geo.size.width/1.1 )
                    .onAppear{
                        withAnimation(.linear(duration: 30).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack{
                    // Logo and Title: animate ease out for 0.7 seconds and start 0.2 after everything sets in
                    VStack{
                        if(animateViewIn) {
                            VStack{
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .fontDesign(.serif)
                                
                                Text("Harry Potter")
                                    .font(.custom("Times", size: 45))
                                    .fontWeight(.semibold)
                                    .fontDesign(.serif)
                                
                                Text("Trivia")
                                    .font(.custom("Times",size: 30))
                                    .fontWeight(.semibold)
                                    .fontDesign(.serif)
                            }
                            .padding(.top,65)
                        }
                    }
                    .animation(.easeInOut(duration: 1.7).delay(0.8).repeatForever(), value: animateViewIn)
                    
                    Spacer()
                    
                    // Recent Scores Tracker
                    VStack {
                        
                        if animateViewIn {
                            VStack{
                                Text("Recent Scores")
                                    .font(.title2)
                                
                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(.black.opacity(0.7))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }.animation(.linear(duration:1).delay(3),value:animateViewIn)
                    
                    Spacer()
                    
                    //Buttons
                    HStack{
                        Spacer()
                        VStack{
                            if(animateViewIn){
                                Button{
                                    //Show instruction screen
                                    showInstructionScreen.toggle()
                                }label:{
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(color:.yellow,radius: 3)
                                }.transition(.offset(x:-geo.size.width/4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(1.7), value:animateViewIn)
                        .sheet(isPresented: $showInstructionScreen) {
                            Instructions()
                        }
                        Spacer()
                        
                        VStack{
                            if(animateViewIn){
                                Button(){
                                    //Click to start new game
                                    playGame.toggle()
                                    
                                }label:{
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .padding(.horizontal,50)
                                        .padding(.vertical,7)
                                        .background(.brown)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                        .fontDesign(.serif)
                                }
                                //Animation effect: scale up and down
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear{
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y:geo.size.height/3))
                                .fullScreenCover(isPresented: $playGame) {
                                    Gameplay()
                                }


                            }
                        }.animation(.easeOut(duration: 0.7).delay(0.2), value: animateViewIn)
                        
                        Spacer()
                        VStack{
                            if(animateViewIn){
                                Button{
                                    //Show settings screen
                                    showSettingsScreen.toggle()
                                }label:{
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(color:Color("maroon"),radius: 5)
                                }
                                .transition(.offset(x:geo.size.width/4))
                                .sheet(isPresented: $showSettingsScreen) {
                                    Settings()
                                }
                            }
                        }.animation(.easeOut(duration: 0.7).delay(1.7), value:animateViewIn)
                        
                        Spacer()
                    }.frame(width:geo.size.width)
                    
                    Spacer()
                    
                }
                
            }.frame(width: geo.size.width, height: geo.size.height)
            
        }
        .ignoresSafeArea()
        .onAppear{
            //            playAudio()
            animateViewIn = true
        }
    }
    
    private func playAudio(){
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
