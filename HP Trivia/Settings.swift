//
//  Settings.swift
//  HP Trivia
//
//  Created by Shriman on 2023-07-25.
//

import SwiftUI


struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    var body: some View {
        ZStack{
            //background image
           InfoBackgroundImage()
            VStack{
                Text("Which books would you like to see questions from ?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .fontDesign(.serif)
                    .foregroundColor(.black)
                
                ScrollView{
                    LazyVGrid(columns:[GridItem(), GridItem()]) {
                        ForEach(0..<7){ i in
                            if (store.books[i] == .active || (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i+1)"))){
                                ZStack(alignment: .bottomTrailing){
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Image(systemName:"checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.books[i] = .inactive
                                    store.saveStatus()
                                }
                                .task{
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                            }
                            else if(store.books[i] == .inactive){
                                ZStack(alignment: .bottomTrailing){
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.3))
                                    
                                    Image(systemName:"circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green.opacity(0.5))
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                            }
                            else{
                                ZStack{
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.7))
                                    
                                    Image(systemName:"lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color:.white.opacity(0.75),radius:3)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    let product = store.products[i-4] // do i - 4 since hp5 is at index
                                    
                                    Task{
                                        await store.purchase(product)
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                }
                
                // Button to dismiss view
                Button("Done"){
                    dismiss()
                }.doneButton()
            }.foregroundColor(.black)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(Store())
    }
}
