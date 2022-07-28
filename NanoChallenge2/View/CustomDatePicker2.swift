//
//  CustomDatePicker.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 29/07/22.
//

import SwiftUI

struct CustomDatePicker2: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        sortDescriptors: []
     ) var tasks: FetchedResults<Task>
    
    @StateObject var taskModel : TaskViewModel
    @Binding var currentDate: Date
    
    @State var currentMonth: Int = 0
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            let days : [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            
            HStack(spacing: 20){
       
             
                
                Button {
                    withAnimation{
                        currentMonth -= 1
                        
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size:16))
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate())
                        .font(.system(size:14))
                        .fontWeight(.semibold)
                  
                }
                
                
                
                Button {
                    withAnimation{
                        currentMonth += 1
                        
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size:16))
                }
                
                
            }
            .frame(maxWidth:.infinity,alignment: .center)
            .padding(.horizontal)
            
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
            
            // Dates
            // Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(extractDate()) { value in
                    
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color(.black))
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
//            VStack(spacing :15) {
//                Text("Tasks")
//                    .font(.title2.bold())
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
            .padding()
            .padding(.top,20)
        }
        .frame(maxHeight :.infinity,alignment: .top)
        .onChange(of: currentMonth) { newValue in
            
            // updating month
            currentDate = getCurrentMonth()
        }
        // Dates
        
    
    }
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        VStack {
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate ?? Date(), date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.system(size:14))
                        .foregroundColor(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate ?? Date(), date2: currentDate) ? .white : Color(.red))
                        .frame(width: 8, height: 8)
                    
                    Spacer()
                }else {
                    Text("\(value.day)")
                        .font(.system(size:14))
                        .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                
            }
        }
//        .padding(.vertical,8)
//        .frame(height: 60, alignment: .top)
    }
    
    // checking dates
    func isSameDay(date1:Date,date2:Date)-> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extracting year and month for display
    func extraDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date
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
    
}


extension Date{
    func getAllDates() -> [Date]{
        let calendar = Calendar.current
//        let range = calendar.range(of: .day, in: .month, for: self)!
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
     
        return range.compactMap( { day -> Date in
            
            return calendar.date(byAdding: .day, value: day-1, to: startDate)!
            
        })
        
    }
}
