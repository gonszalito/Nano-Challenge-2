import SwiftUI
struct CarouselItem: Identifiable {
    var id: Int
    var title: String
    var color: Color
}

class Store: ObservableObject {
    @Published var items: [CarouselItem]
    
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]

    // dummy data
    init() {
        items = []
        for i in 0...7 {
            let new = CarouselItem(id: i, title: "CarouselItem \(i)", color: colors[i])
            items.append(new)
        }
    }
}


struct CarouselView: View {
    
    @StateObject var store = Store()
    @StateObject var taskModel : TaskViewModel = TaskViewModel()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        
        ZStack {
            
            ForEach(taskModel.allWeeks.enumerated(),id: \.self) { (index,week) in
                
                // article view
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.indigo)
                    Text("Test")
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                
//                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
//                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                .offset(x: myXOffset(index), y: 1)
                .zIndex(1.0 - abs(distance(index)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 400
              
                    print(value.translation.width)
                }
                .onEnded { value in
                    withAnimation {
                        if value.predictedEndTranslation.width > 0 {
                            draggingItem = snappedItem + 1
                        } else {
                            draggingItem = snappedItem - 1
                        }
                        
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                        snappedItem = draggingItem
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(store.items.count))
    }
    
    func myXOffset(_ CarouselItem: Int) -> Double {
        let angle = Double.pi * 2 / Double(store.items.count) * distance(CarouselItem)
        return sin(angle) * 200
    }
    
}

struct CreateCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .environmentObject(Store())
    }
}
