//
//  CustomDatePicker.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 29/07/22.
//

import SwiftUI

struct CustomDatePickerSmall: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        sortDescriptors: []
    ) var tasks: FetchedResults<Task>
    
    @StateObject var taskModel : TaskViewModel
    @Binding var currentDate: Date
    
    @State var currentWeek: Int = 0
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            let days : [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation{
                        currentMonth -= 1
                        
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation{
                        currentMonth += 1
                        
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                
                
            }
            .border(.blue)
            .padding(.horizontal)
            
            // Day View
            HStack(spacing: 0){
                ForEach(days,id: \.self){
                    day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                }
            }.border(.red)
            //
            //            Dates
            //            Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            VStack{
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(extractDate()) { value in
                    
                    
                    CardView(value: value)
                        .background(
//                            Capsule()
                                
                            
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }.border(.black)
            
            
            
            
            
            
            
            }
        }
        .frame(maxHeight :.infinity,alignment: .top)
        .onChange(of: currentMonth) { newValue in
            
            // updating month
            currentDate = getCurrentMonth()
        }
        
        
        
    }
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1{
                VStack{
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate ?? Date(), date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : .primary)
                        .frame(height:30,alignment: .center)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(Circle().fill(Color(.black))
//                            .padding(.vertical,2)
                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
//                        .border(.brown)
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : Color(.red))
//                        .frame(width: 8, height: 8)
                    
//                    Spacer()
                }else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
                }.padding(.top,10)
            }
        }
        .frame(maxHeight:.infinity, alignment: .center)
//        .padding(.vertical,8)
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
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current
        
        //getting current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth , to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    
    func extractDate()->[DateValue]{
        let calendar = Calendar.current
        
        // Get current month
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap{date -> DateValue in
            
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
    
    func getCurrentWeek()->Date{
        let calendar = Calendar.current
        
        //getting current month date
        guard let currentWeek = calendar.date(byAdding: .weekOfMonth, value: self.currentWeek , to: Date()) else {
            return Date()
        }
        
        return currentWeek
    }
    
    
    func extractWeek()->[DateValue]{
        let calendar = Calendar.current
        
        // Get current month
        let currentWeek = getCurrentWeek()
        
        var days = currentWeek.getAllDates().compactMap{date -> DateValue in
            
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

//
//extension Date{
//    func getAllDates() -> [Date]{
//        let calendar = Calendar.current
//        
//        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
//        
//        let range = calendar.range(of: .day, in: .month, for: startDate)!
//        
//        return range.compactMap( { day -> Date in
//            
//            return calendar.date(byAdding: .day, value: day-1, to: startDate)!
//            
//        })
//    }
//    
//    func gettAllWeek() -> [Date]{
//        var calendar = Calendar(identifier: .gregorian)
//        
//        //        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
//        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: self)
//        let weekNumber  = calendar.component(.weekOfYear, from: self)
//        //
//        let startDate = DateComponents(calendar: calendar, weekOfYear: weekNumber, yearForWeekOfYear: yearForWeekOfYear).date!
//        //        let endDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
//        //
//        //        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
//        //
//        //        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
//        
//        //        let weekRange = calendar.range(of: .day, in: .weekOfYear, for: components)
//        //        let range = calendar.range(of: .day, in: .weekOfYear, for: startOfWeek)!
//        
//        //        return weekRange.compactMap( { day -> Date in
//        //
//        //            return calendar.date(byAdding: .day, value: day-1, to: startDate)!
//        //
//        //        })
//        
//        calendar.firstWeekday = 7
//        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
//        
//        var week : [Date] = []
//        
//        
//        (1...7).forEach{ day in
//            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
//                week.append(weekday)
//            }
//        }
// 
//        
//        return week
//        
//    }
//}
