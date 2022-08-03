//import SwiftUI
//
//import SwiftUI
//
////struct DateValue2: Identifiable {
////    var id = Int
////    var day : Int
////    var date: [Date]
////}
//
//struct DateValue2: Identifiable,Hashable {
//    var id: Int
//    var day : Int
//    var date : [Date]
////    var startDate : Date
////    var endDate : Date
////    var range : Range<Date>
////    var dateCom : DateComponents
//    
//}
//
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
//class WeekStore : ObservableObject {
//    @Published var allWeeks : [DateValue2] = []
//    
//    @Published var currentDate : Date = Date()
//    
//    @Published var currentIndex : Int = 0
//    
//    @Published var indexToUpdate : Int = 0
//    @Published var currentWeek: [Date] = []
//    @Published var nextWeek : [Date] = []
//    @Published var previousWeek : [Date] = []
//    
//    init() {
//        fetchCurrentWeek()
//        fetchPreviousNextWeek()
//        appendAll()
//    }
//    func doAll() {
//        fetchCurrentWeek()
//        fetchPreviousNextWeek()
//        appendAll()
//    }
//    
//    func appendAll() {
//        var  newWeek = DateValue2(id: 0, day: 1, date: currentWeek)
//        allWeeks.append(newWeek)
//        
//        newWeek = DateValue2(id: 2, day: 0, date: nextWeek)
//        allWeeks.append(newWeek)
//   
//        newWeek = DateValue2(id: 1, day: 2, date: previousWeek)
//        allWeeks.append(newWeek)
//       
//     
//    }
//    
//    func addToIndicator(value : Int) {
////        indexToUpdate += value
////
////        if indexToUpdate >2{
//////            indexToUpdate
////        }
//    }
//    
//    
//    func update(index : Int) {
//        
//      
//        var value : Int = 0
//        
//        if index < currentIndex {
//            value = 1
//            if indexToUpdate ==  2 {
//                indexToUpdate = 0
//            } else {
//                indexToUpdate = indexToUpdate + 1
//            }
////            addWeek(index: indexToUpdate, value: value)
//        } else {
//            value = -1
//            if indexToUpdate ==  0{
//                indexToUpdate = 2
//            } else {
//                indexToUpdate = indexToUpdate - 1
//            }
////            addWeek(index: indexToUpdate, value: value)
//        }
//        currentIndex = index
//        addWeek(index: indexToUpdate, value: value)
//        
////
////        allWeeks[indexToUpdate].date.removeAll()
////        var calendar = Calendar(identifier: .gregorian)
////        let today = Calendar.current.date(byAdding: .day, value: 7 * value , to: self.currentDate)!
////        self.currentDate = today
////
////        calendar.firstWeekday = 7
////        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
////
////        (1...7).forEach{ day in
////            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
////                allWeeks[indexToUpdate].date.append(weekday)
////            }
////
////        }
////
//    }
//    
//    func addWeek(index: Int, value: Int) {
//        allWeeks[index].date.removeAll()
//        var calendar = Calendar(identifier: .gregorian)
//        let today = Calendar.current.date(byAdding: .day, value: 7 * value , to: self.currentDate)!
//        self.currentDate = today
//  
//        calendar.firstWeekday = 7
//        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
//     
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
//                allWeeks[index].date.append(weekday)
//            }
//            
//        }
//        
//    }
//    
//    func dateToString(date: Date,format: String)->String{
//        let formatter = DateFormatter()
//        
//        formatter.dateFormat = format
//        
//        return formatter.string(from: date)
//    }
//    
//    func fetchCurrentWeek(){
//        
//        let today = currentDate
//        var calendar = Calendar(identifier: .gregorian)
//
//        calendar.firstWeekday = 7
//        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
//
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
//                currentWeek.append(weekday)
//            }
//            
//        }
//        
//    }
//    
//    
//    func fetchNextWeek(){
//        currentWeek.removeAll()
//        
//        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentWeek.first ?? Date())!
//        
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.firstWeekday = 7
//        
//        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
//        
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
//                currentWeek.append(weekday)
//            }
//            
//        }
//    }
//    
//    func fetchPreviousNextWeek(){
//        
//        nextWeek.removeAll()
//        
//        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate )!
//
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.firstWeekday = 7
//        
//        let startOfWeekNext = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
//        
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekNext){
//                nextWeek.append(weekday)
//            }
//            
//        }
//        
//        previousWeek.removeAll()
//        let previousWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
//
//        
//        let startOfWeekPrev = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: previousWeekToday))!
//        
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekPrev){
//                previousWeek.append(weekday)
//            }
//            
//        }
//
//
//    }
//    
//    
//    
//}
//
//
//
//struct CarouselView: View {
//    
//    @StateObject var store = Store()
//    @StateObject var weekStore = WeekStore()
//    @State private var snappedItem = 0.0
//    @State private var draggingItem = 0.0
//    
//    @State var currentIndex :Item2 = Item2(id: 0, title: "ad", color: .red)
//    var body: some View {
//        
//        ZStack {
//            ForEach(store.items) { item in
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
//        ZStack {
//            ForEach(weekStore.allWeeks) { week in
//                
//                // article view
//                VStack{
//                HStack {
//                    ForEach(0..<7) { index in
//                        VStack(spacing: 20) {
//                            Text(weekStore.dateToString(date: week.date[index], format: "EEE"))
//                                .font(.system(size:14))
//                                .fontWeight(.semibold)
//                                .frame(maxWidth:.infinity)
//                                
//                        
//                        Text(weekStore.dateToString(date: week.date[index], format: "d"))
//                            .font(.system(size:14))
//                            .frame(maxWidth:.infinity)
////                        .padding()
////                        .background(
////                            RoundedRectangle(cornerRadius: 18)
////                                .fill(.white)
////
////                        )
//                        }
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//                .background(
//                    Rectangle()
//                        .fill(.white)
//                  
//                )
//                
//            }
//                //                .frame(width:UIScreen.main.bounds.width, height: 200)
//                //                .frame(maxWidth: .infinity, alignment:.center)
//                
//                //                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
//                //                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
//                .offset(x: myXOffset(week.id), y: 0)
//                .zIndex(1.0 - abs(distance(week.id)) * 0.1)
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
//                                                
//                        
//                        snappedItem = draggingItem
////                         When Swiped to the Right
//                        print(snappedItem)
//                        weekStore.update(index: Int(snappedItem))
////                        if snappedItem < 0 {
////                            weekStore.update(index: Int(snappedItem))
////
////                            // When Swiped to the Left
////                        } else {
////
////                        }
////                        print(snappedItem)
////                        print(weekStore.allWeeks)
//                    }
//                }
//        )
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
