////
////  SnapCarousel.swift
////  NanoChallenge2
////
////  Created by Jonathan Andryana on 29/07/22.
////
//
//import SwiftUI
//
//struct SnapCarousel<Content: View,T:Identifiable>: View {
//    var content:(T) -> Content
//    var list: [T]
//    
//    //Properties
//    var spacing: CGFloat
//    var trailingSpace : CGFloat
//    @Binding var index: Int
//    
//    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items: [T],@ViewBuilder content: @escaping (T)->Content) {
//        self.list = items
//        self.spacing = spacing
//        self.trailingSpace = trailingSpace
//        self._index = index
//        self.content = content
//    }
//    
//    var body: some View{
//        GeometryReader{proxy in
//            content
//        }
//    }
//}
//
////struct SnapCarousel_Previews: PreviewProvider {
////    static var previews: some View {
////        SnapCarousel<<#Content: View#>, <#T: Identifiable#>>()
////    }
////}
