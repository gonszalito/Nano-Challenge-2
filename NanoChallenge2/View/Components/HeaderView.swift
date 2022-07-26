//
//  HeaderView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 27/07/22.
//

import SwiftUI

// MARK: Header
func HeaderView()->some View {
    
    HStack(spacing: 10){
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text(Date().formatted(date : .abbreviated, time: .omitted))
                .foregroundColor(.gray)
            
            Text("Today")
                .font(.largeTitle.bold())
        }
        .hLeading()
        
        Button {
            
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 30))
        }
        Button {
            
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 30))
        }
        
        
    }
    .padding()
    .background(.white)
}
