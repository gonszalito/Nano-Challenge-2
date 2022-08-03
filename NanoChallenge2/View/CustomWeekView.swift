//
//  CustomDatePicker.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 29/07/22.
//

import SwiftUI
import SwiftUISnappingScrollView
import ACarousel

struct CustomWeekView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        sortDescriptors: []
     ) var tasks: FetchedResults<Task>
    
    @State var startingOffsetY : CGFloat = UIScreen.main.bounds.height * 0.85
    
    @State var currentDragOffsetY: CGFloat = 0
    
    @StateObject var taskModel : TaskViewModel
    @Binding var currentDate: Date
    
    @State var index : Int = 0
    @State var currentWeek: Int = 0
    @State var weekIndex : Int = 0
    @State var currentMonth: Int = 0
    @State var test : [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    @State var dateValues : [DateValue] = []
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            let days : [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        
            
            // Day View
            HStack(spacing: 0){
                ForEach(days,id: \.self){
                    day in
                    Text(day)
                        .font(.system(size:14))
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                }
            
            }
            
//            TabView(selection: $currentWeek) {
//
//                        ForEach((weekIndex-1...weekIndex+1), id: \.self) { index in
//                            let columns = Array(repeating: GridItem(.flexible()), count: 7)
//                                  LazyVGrid(columns: columns, spacing: 15){
//                        ForEach(extractPrevWeek(value: index)) { value in
//
//                            LazyHStack{
//                          Text("ADsf")
//                            }
////                            .offset(x : startingOffsetY)
//                            .offset(x: currentDragOffsetY)
//                            .tag(index)
//                            .gesture(
//                              DragGesture()
//                                  .onChanged { value in
//                                      withAnimation(.spring()){
//                                          currentDragOffsetY = value.translation.width
//                                      }
//
//                                  }
//                                  .onEnded{ value in
//                                      withAnimation(.spring()) {
//                                      currentDragOffsetY = 0
//
//                                  }
//                                  }
//                            )
//                        }
////                                  }.onChange(of: currentWeek){ newValue in
////
////
//////                                      weekIndex = weekIndex + 1
////                                  }
//
//                                  }
//
//                                  .onChange(of: currentWeek){ value in
//                                      weekIndex = 0
//                                  }
//                        }
//
//            }
//
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//
//            TabView(selection: $currentWeek) {
//
//                        ForEach((test), id: \.self) { index in
//                           Text("\(index)")
//                        }.onTapGesture {
//                            print(currentWeek)
//                        }
//
//
//
//            }
//
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//
//            TabView(selection: $index) {
//                           ForEach((test), id: \.self) { value in
//                               Text("\(value)").onTapGesture {
//                                   print(index)
//                               }
//
//
//                           }.onChange(of: index){ value in
//                               test.append("tsdf")
//                               print("owr")
//                           }
//
//
//                       }.onChange(of: index){ value in
//                           test.append("tsdf")
//                           print("owr")
//
//                       }
//
//                       .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//
            
            TabView(selection: $currentWeek) {
                
                        ForEach((weekIndex-1...weekIndex+1), id: \.self) { index in
                            let columns = Array(repeating: GridItem(.flexible()), count: 7)
                                  LazyVGrid(columns: columns, spacing: 15){
                        ForEach(extractPrevWeek(value: index)) { value in

                            LazyHStack{
                            CardView(value: value)
                                .background(
                                    Capsule()
                                        .fill(Color(.black))
                                        .padding(.horizontal,8)
                                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)

                                )
                                .onTapGesture {
                                    currentDate = value.date
                                    print(value)
                                }
                            }
                            .tag(index)
                        }
//                                  }.onChange(of: currentWeek){ newValue in
//
//
////                                      weekIndex = weekIndex + 1
//                                  }

                                  }
                                  .onChange(of: currentWeek){ value in
                                   currentWeek
                                  }
                        }
              
            }
        
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Dates
            // Lazy Grid
//            let columns = Array(repeating: GridItem(.flexible()), count: 7)
//            LazyVGrid(columns: columns, spacing: 15){
//
//
//
////                ForEach(extractPrevWeek()) { value in
////
////
////                    CardView(value: value)
////                        .background(
////                            Capsule()
////                                .fill(Color(.black))
////                                .padding(.horizontal,8)
////                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
////
////                        )
////                        .onTapGesture {
////                            currentDate = value.date
////                        }
////                }
//
////                VStack{
////                    TabView(selection: $index) {
////                        ForEach((extractWeek()), id: \.self) { value in
//////                            CardView()
////
////                            CardView(value: value)
////
////                        }
////                    }
////                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
////                    Text("DSAFdsf")
////                }.hTop()
////                ForEach(extractWeek()) { value in
////
////                    CardView(value: value)
////                        .background(
////                            Capsule()
////                                .fill(Color(.black))
////                                .padding(.horizontal,8)
////                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
////
////                        )
////                        .onTapGesture {
////                            currentDate = value.date
////                        }
////                }
//
//            }.frame(maxWidth:.infinity)

            
            
//            LazyHStack {
//                ForEach(extractWeek()) { value in
//
//                    CardView(value: value)
//                        .background(
//                            Capsule()
//                                .fill(Color(.black))
//                                .padding(.horizontal,8)
//                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
//
//                        )
//                        .onTapGesture {
//                            currentDate = value.date
//                        }
//                }
//            }
            


            .padding()
            .padding(.top,20)
        }
//        .frame(maxHeight :.infinity,alignment: .top)
        .onChange(of: currentWeek) { newValue in
            
            // updating month
            currentDate = getCurrentWeek()
        }
        
        
    
    }
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate ?? Date(), date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : .primary)
                        .frame(height:30,alignment: .top)
                        .frame(maxWidth: .infinity)
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : Color(.red))
                        .frame(width: 8, height: 8)
                    
                    Spacer()
                }else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
            }
            
        }
        .padding(.vertical,8)
//        .frame(height: 30, alignment: .top)
    }
    
    
    
    
    // checking dates
    func isSameDay(date1:Date,date2:Date)-> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extracting year and month for display
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    
//
    
    func getCurrentWeek()->Date{
        let calendar = Calendar.current
        
        //getting current month date
        guard let currentWeek = calendar.date(byAdding: .weekOfYear, value: self.currentWeek , to: Date()) else {
            return Date()
        }
        
        return currentWeek
    }

    func getCurrentWeek(value: Int)->Date{
        let calendar = Calendar.current
        
        //getting current month date
        
        guard let currentWeek = calendar.date(byAdding: .weekOfYear, value: self.currentWeek+value , to: Date()) else {
            return Date()
        }
        
        return currentWeek
    }

    
    func extractWeek()->[DateValue]{
        let calendar = Calendar.current
        
        // Get current month
        let currentWeek = getCurrentWeek()
        
        var days = currentWeek.gettAllWeek().compactMap{date -> DateValue in
            
            //get day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
    
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday-1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
    
    func extractPrevWeek(value: Int)->[DateValue]{
        let calendar = Calendar.current
        
        // Get current month
        let currentWeek = getCurrentWeek(value: currentWeek-value)
        
        var days = currentWeek.gettAllWeek().compactMap{date -> DateValue in
            
            //get day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
    
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday-1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
    
    
    func extractNextWeek()->[DateValue]{
        let calendar = Calendar.current
        
        // Get current month
        let currentWeek = getCurrentWeek(value: currentWeek+1)
        
        var days = currentWeek.gettAllWeek().compactMap{date -> DateValue in
            
            //get day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
    
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday-1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
    
    
    
}


