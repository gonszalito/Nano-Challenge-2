
//
//  ContentView.swift
//  ScrollView_Tests
//
//  Created by Jean-Marc Boullianne on 7/30/20.
//
import SwiftUI

struct tsetView: View {
    
  
    
//    @StateObject var colors2: [Color] = [.blue, .green, .red, .orange]
    @State var colors: [Color] = [.blue, .green, .red, .orange]
    
  
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 0) {
            
            ForEach(0..<colors.count,id: \.self) {  i in
                VStack {
                 colors[i]
                        .frame(height : 400)
                        .frame(width : UIScreen.main.bounds.size.width, alignment: .center)
                     .cornerRadius(10)
//                     .onTapGesture(){
//                         colors.append(.brown)
//                     }
                     .onChange(of: i) { value in
                         print(i)
                         colors.append(Color.brown)
                     }
                }
       
            }
        }
//        .gesture(DragGesture()
//                 )
    }
    
}

