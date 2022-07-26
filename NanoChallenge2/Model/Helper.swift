//
//  Helper.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI

// MARK: UI Design Helper
extension View {
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCenter()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    func hTop()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .top)
    }
    func hBot()-> some View{
        self
            .frame(maxWidth: .infinity, alignment: .bottom)
    }
    func toTop()->some View{
        self
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .border(Color.red)
    }
    func toBot()->some View{
        self
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
            .border(Color.blue)
    }
    
    // MARK: Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}
