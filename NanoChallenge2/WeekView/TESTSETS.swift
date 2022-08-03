//import SwiftUI
//
//import SwiftUI
//
//struct Item2: Identifiable {
//    var id: Int
//    var title: String
//    var color: Color
//}
//
//class Store: ObservableObject {
//    @Published var items: [Item2]
//
//    var colors: [Color] = [.blue, .red, .orange]
//    var dates : [Date] = [Date()]
//
//    // dummy data
//    init() {
//        items = []
//        for i in 0...2 {
//            let new = Item2(id: i, title: "Item \(i)", color: colors[i])
//            items.append(new)
//        }
//    }
//
//    func change() {
//        items[2].title = "asdfsdfa"
//    }
//}
//
//
//
//struct CarouselView2: View {
//
//    @StateObject var store = Store()
////    @StateObject var weekStore = WeekStore()
//    @State private var snappedItem = 0.0
//    @State private var draggingItem = 0.0
//
//    @State var Dates : [Date] = []
//
//    @State var currentIndex :Item2 = Item2(id: 0, title: "ad", color: .red)
//    var body: some View {
//
//        ZStack {
//            ForEach(store.dates) { item in
//
//                // article view
//
//                HStack {
//
//                    Text(item.title)
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 18)
//
//                                .fill(item.color)
//                                .frame(width: UIScreen.main.bounds.width)
//                        )
//                }
//                //                .frame(width:UIScreen.main.bounds.width, height: 200)
//                //                .frame(maxWidth: .infinity, alignment:.center)
//
//                //                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
//                //                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
//                .offset(x: myXOffset(item.id), y: 0)
//                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
//            }
//        }
//        .frame(maxHeight:.infinity , alignment : .top)
//        .padding(.top,50)
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    draggingItem = snappedItem + value.translation.width / 400
//                }
//                .onEnded { value in
//                    withAnimation {
//                        print(value.predictedEndTranslation.width)
//                        if value.predictedEndTranslation.width > 0 {
//                            draggingItem = snappedItem + 1
//                        } else {
//                            draggingItem = snappedItem - 1
//                        }
//
//
//                        snappedItem = draggingItem
//
//                        print(snappedItem)
//                        store.change()
//                    }
//                }
//        )
//
//
//
//    }
//
//    func distance(_ item: Int) -> Double {
//        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
//    }
//
//    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
//        return sin(angle) * 200
//    }
//
//
//}
