//
//  TaskViewModel.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI
import CoreData

class TaskViewModel : ObservableObject{
    
    // MARK: New Task Properties
    @Published var taskTitle : String = ""
    @Published var taskDescription : String = ""
    @Published var taskDate : Date = Date()
    @Published var taskFinishTime : Date = Date()
    
    // MARK: Determine Task Page Title
    @Published var taskPageTitle : String = ""
    
    // MARK: Edit Finish Time
    @Published var showFinishPicker: Bool = false
    
    // MARK: To open Edit Mode
    @Published var openEditTask: Bool = false
    
    // MARK: Show Date Picker
    @Published var showDatePicker: Bool = false
    
    // MARK: Show Time Picker
    @Published var showStartPicker: Bool = false
    
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
    
    // MARK:
    
    // MARK: Finish Time Observer
    private func finishObserver() {
       

            
    }
    
    // MARK: Change Finish Time when lower
    func changeTime() {
        if taskDate > taskFinishTime {
            taskFinishTime = taskDate
        }
    }
    
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
    
    func addTask(context : NSManagedObjectContext)->Bool{
        
        // MARK: Updating Existing Data
        var task : Task!
        if let editTask = editTask {
            task = editTask
        }else{
            task = Task(context: context)
        }
        
        task.taskTitle = taskTitle
        task.taskDescription = taskDescription
        task.taskDate = taskDate
        task.taskFinishTime = taskFinishTime
        task.isCompleted = false
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    
    // MARK: Resetting Data
    func resetTaskData(){
        showFinishPicker = false
        editTask = nil
        taskTitle = ""
        taskTitle = ""
        taskDescription = ""
        taskDate = Date()
        taskFinishTime = Date()
    }
    
    // MARK: Set Task when editing
    func setupTask() {
        if let editTask = editTask {
            taskTitle = editTask.taskTitle ?? ""
            taskDescription = editTask.taskDescription ?? ""
            taskDate = editTask.taskDate ?? Date()
            taskFinishTime = editTask.taskFinishTime ?? Date()
        }
    }
}
