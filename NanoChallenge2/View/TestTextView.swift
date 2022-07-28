//
//  TestTextView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 28/07/22.
//

import SwiftUI

struct TestTextView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack {
                Text("Night Sleep")
                    .font(.system(size: 32,weight:.bold))
//                .frame(alignment: .leading)
              
            }
            
            Text("Time for night time sleep. Lets get ready to sleep")
                .font(.system(size: 16,weight:.bold))
//                .frame(alignment: .leading)
                
        }

        .frame(width: 300, height: 180)
        .background(.blue)
        .cornerRadius(25)
  
    }
}

struct TestTextView_Previews: PreviewProvider {
    static var previews: some View {
        TestTextView()
    }
}
