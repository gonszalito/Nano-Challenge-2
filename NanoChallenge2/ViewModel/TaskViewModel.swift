//
//  TaskViewModel.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI

class TaskViewModel : ObservableObject{
    
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDate : Date = Date()
    
    // MARK: Filtered Today Tasks
    @Published var filteredTasks: [Task]?
    
    // MARK: New Task View
    @Published var addNewTask: Bool = false
    
    // MARK: Edit Data
    @Published var editTask: Task?
    
    // MARK: Initializing
    init() {
        fetchCurrentWeek()
//        filterTodayTasks()
    }
    
//    // MARK: Filtering Today's Tasks
//    func filterTodayTasks(){
//        DispatchQueue.global(qos: .userInteractive).async {
//            
//            let calendar = Calendar.current
//            
//            let filtered = self.storedTasks.filter{
//                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDate)
//            }
//                .sorted {task1, task2 in
//                    return task2.taskDate < task1.taskDate
//                }
//            DispatchQueue.main.async {
//                withAnimation{
//                    self.filteredTasks = filtered
//                }
//            }
//            
//        }
//    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
            
        }
        
    }
    
    // MARK: Extracting Date
    func extractDate(date: Date,format: String)->String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Check if current Date is Today
    func isToday(date:Date)->Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDate, inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(date:Date)->Bool{
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        let isToday = calendar.isDateInToday(date)
        
        return (hour == currentHour && isToday)
    }
}
