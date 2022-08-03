//
//  ContentView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var currentIndex: Int = 0
    
    var body: some View {
//       SnapCarousel(UIState: UIStateModel())
        CustomWeekHeader()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
