import SwiftUI
struct Item2: Identifiable {
    var id: Int
    var title: String
    var color: Color
}

class Store: ObservableObject {
    @Published var items: [Item2]
    
    let colors: [Color] = [.red, .orange, .blue, .brown]

    // dummy data
    init() {
        items = []
        for i in 0...3 {
            let new = Item2(id: i, title: "Item \(i)", color: colors[i])
            items.append(new)
        }
    }
}


struct CarouselView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        
        ZStack {
            ForEach(store.items) { item in
                
                // article view
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(item.color)
                    Text(item.title)
                        .padding()
                }
                .frame(width: 200, height: 200)
                
                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                .offset(x: myXOffset(item.id), y: 0)
                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 400
                }
                .onEnded { value in
                    withAnimation {
                        print(value.predictedEndTranslation.width)
                        if value.predictedEndTranslation.width > 0 {
                            draggingItem = snappedItem + 1
                                           } else {
                                               draggingItem = snappedItem - 1
                                           }
                       
                        

                        snappedItem = draggingItem
                        
                        store.items.append(Item2(id: 100+store.items.count, title: "dasf+\(store.items.count)", color: .cyan))
//                        store.items.removeAll()
                        
                        print(snappedItem)
                        
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(item)
        return sin(angle) * 200
    }
    
}
