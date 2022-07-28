////
////  CarouselList.swift
////  NanoChallenge2
////
////  Created by Jonathan Andryana on 28/07/22.
////
//
//import SwiftUI
//
//struct CarouselList: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct List : View {
//    var body: some View{
//        HStack(spacing: 0){
//            let width = UIScreen.main.bounds.width
//        }
//    }
//}
//
//struct Carousel : UIViewRepresentable {
//    
//    @Binding var width : CGFloat
//    @Binding var page : Int
//    
//    func makeUIView(context: Context) -> UIScrollView {
//        let view = UIScrollView()
//        view.isPagingEnabled = true
//        view.contentSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//    }
//    
//    func updateUIView(_ uiView: UIScrollView, context: Context) {
//        <#code#>
//    }
//}
//
//struct CarouselList_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselList()
//    }
//}
//
