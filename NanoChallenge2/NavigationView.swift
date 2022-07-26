//
//  NavigationView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI

struct CustomNavigationView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                VStack(spacing: 5) {
                    
                    Capsule()
                        .fill(Color("ColorPrimary"))
                        .frame(width: 30, height: 3)
                    Capsule()
                        .fill(Color("ColorPrimary"))
                        .frame(width: 30, height: 3)
                    Capsule()
                        .fill(Color("ColorPrimary"))
                        .frame(width: 30, height: 3)
                }
                Spacer()
                Image(systemName: "bell")
                    .foregroundColor(Color("ColorYellow"))
                Image(systemName: "text.bubble")
                    .foregroundColor(.blue)
            }
            .font(.body)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .overlay(
                Text("Bank App")
            )
            HStack(spacing: 0){
                Color("Color1")
                    .frame(minWidth: 0, maxWidth: .infinity)
                Color("Color2")
                    .frame(minWidth: 0, maxWidth: .infinity)
                Color("Color3")
                    .frame(minWidth: 0, maxWidth: .infinity)
                Color("Color4")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(height:4)
        }
//        .padding(.top,
//                 CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView()
            .previewLayout(.sizeThatFits)
    }
}
