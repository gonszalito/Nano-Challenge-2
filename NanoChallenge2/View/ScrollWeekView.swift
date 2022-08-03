//
//  ScrollWeekView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 03/08/22.
//

import SwiftUI

struct ScrollWeekView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ScrollWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollWeekView()
    }
}

//struct ScrollWeekView2: View {
//    @State private var ScrollViewOffsetPreferenceKey : K
//var body: some View {
//         ScrollView {
//             ZStack {
//                 LazyVStack {
//                     ForEach(0...100, id: \.self) { index in
//                         Text("Row \(index)")
//                     }
//                 }
//                 GeometryReader { proxy in
//                     let offset = proxy.frame(in: .named("scroll")).minY
//                     Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
//                 }
//             }
//         }
//         .coordinateSpace(name: "scroll")
//         .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
//             print(value)
//         }
// }
//}

struct ScrollView3: View {
    @State private var position = 0
    var body: some View {
        VStack {
            HStack {
                Button("Top") { position = 0 }
                Button("Middle") { position = 500 }
                Button("Bottom") { position = 1000 }
            }
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack {
                        ForEach(0...1000, id: \.self) { index in
                            Text("Row \(index)")
                        }
                    }
                    .onChange(of: position) { value in
                        withAnimation {
                            proxy.scrollTo(value, anchor: .center)
                            
                        }
                    }
                }
            }
        }
    }
}
