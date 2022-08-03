
//
//  ContentView.swift
//  ScrollView_Tests
//
//  Created by Jean-Marc Boullianne on 7/30/20.
//
import SwiftUI

struct tsetView: View {
    
    @State var colors: [Color] = [.blue, .green, .red, .orange]
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            ForEach(0..<colors.count,id: \.self) {  i in
                VStack {
                 colors[i]
                     .frame(width: 250, height: 400, alignment: .center)
                     .cornerRadius(10)
                     .onTapGesture(){
                         colors.append(.brown)
                     }
                     .onChange(of: i) { value in
                         print(i)
                         colors.append(Color.brown)
                     }
                }
       
            }
        }.modifier(ScrollingHStackModifier(items: colors.count, itemWidth: 250, itemSpacing: 30))
        
    }
}

