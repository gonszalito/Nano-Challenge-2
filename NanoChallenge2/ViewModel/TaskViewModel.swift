//
//  TaskViewModel.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI
import CoreData

struct weekArray: Identifiable {
    let id = UUID().uuidString
    let week: [Date]
}

class TaskViewModel : ObservableObject{
    
    @Environment(\.managedObjectContext) var context
    
    @Published var currentWeekIndex : Int = 0
    
    // MARK: New Task Properties
    @Published var taskTitle : String = ""
    @Published var taskDescription : String = ""
    
    // MARK: Start Time/ Deadline
    @Published var taskDate : Date = Date()
    @Published var taskFinishTime : Date = Date()
    
    @Published var inStatus : Bool = false
    @Published var outStatus : Bool = false
    
    @Published var isCompleted : Bool = false
    
    // MARK: Check In Check Out
    @Published var checkIn : Date = Date()
    @Published var checkOut: Date = Date()
    
    @Published var timeTolerance : TimeInterval = 600
    
    @Published var started : Bool = false
    @Published var finished : Bool = false
    
    @Published var dateValues: [DateValue] = []
    
    // MARK: All Tasks
    @Published var allTask : [Task] = []
    
    // MARK: Tab Bar Index
    @Published var weekIndex : Int = 2
    
    @Published var arrAll : [weekArray] = []
    
    // MARK: 3 weeks combined
    @Published var allWeeks : [[Date]] = [[Date()]]
    
    // MARK: Determine Task Page Title
    @Published var taskPageTitle : String = ""
    
    // MARK: Edit Finish Time
    @Published var showFinishPicker: Bool = false
    
    @Published var showSetTimePicker : Bool = false
    
    // MARK: To open Edit Mode
    @Published var openEditTask: Bool = false
    
    // MARK: Show Date Picker
    @Published var showDatePicker: Bool = false
    
    // MARK: Show Time Picker
    @Published var showStartPicker: Bool = false
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Next Week
    @Published var nextWeek : [Date] = []
    
    // MARK: Previous Week
    @Published var previousWeek : [Date] = []
    
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
        fetchPreviousNextWeek()
        appendAllWeek()
        fetchAllTasks()
        dateValues = extractWeek()
//        fetchPreviousNextWeek()
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
    
    func fetchAll() {
        fetchCurrentWeek()
   
    }
    
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
        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "en_US")
        
//        Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
//        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
//
//        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
//
//        guard let firstWeekDay = week?.start else {
//            return
//        }
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                currentWeek.append(weekday)
            }
            
        }
        
    }
    
    func fetchWeek(){
        currentWeek.removeAll()
        let today = currentDate
        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "en_US")
        
//        Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
//        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
//
//        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
//
//        guard let firstWeekDay = week?.start else {
//            return
//        }
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                currentWeek.append(weekday)
            }
            
        }
        
    }
    
    func fetchNextWeek(){
        currentWeek.removeAll()
        
        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        currentDate = nextWeekToday
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                currentWeek.append(weekday)
            }
            
        }
    }
    
//    func refreshWeek() {
//        if weekIndex == 3 {
//            fetchNextWeek()
//            fetchPreviousNextWeek()
////            weekIndex = 2
//        } else if weekIndex == 1 {
//            fetchPreviousWeek()
//            fetchPreviousNextWeek()
////            weekIndex = 2
//        }
//    }
    
    func appendAllWeek() {
        allWeeks.removeAll()
        allWeeks.append(previousWeek)
        allWeeks.append(currentWeek)
        allWeeks.append(nextWeek)
        arrAll.append(weekArray(week: previousWeek))
        arrAll.append(weekArray(week: currentWeek))
        arrAll.append(weekArray(week: nextWeek))
    }
    

    
    func fetchPreviousWeek(){
        currentWeek.removeAll()
        
        let nextWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        currentDate = nextWeekToday
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                currentWeek.append(weekday)
            }
            
        }
        
 
        
    }
    
    func fetchPreviousNextWeek(){
        
        nextWeek.removeAll()
        
        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        
        let startOfWeekNext = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekNext){
                nextWeek.append(weekday)
            }
            
        }
        
        previousWeek.removeAll()
        let previousWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!

        
        let startOfWeekPrev = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: previousWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekPrev){
                previousWeek.append(weekday)
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
        started = false
        finished = false
        inStatus = false
        outStatus = false
    }
    
    // MARK: Set Task when editing
    func setupTask() {
        if let editTask = editTask {
            taskTitle = editTask.taskTitle ?? ""
            taskDescription = editTask.taskDescription ?? ""
            taskDate = editTask.taskDate ?? Date()
            taskFinishTime = editTask.taskFinishTime ?? Date()
            finished = editTask.outStatus
            started = editTask.inStatus
            isCompleted = editTask.isCompleted
            checkIn = editTask.checkIn ?? Date()
            checkOut = editTask.checkOut ?? Date()
            inStatus = editTask.inStatus
            outStatus = editTask.outStatus
            
        }
    }
    
    func fetchAllTasks(){
        
        
    }
    
    func completeTask()->Bool{
        if started == false {
            started.toggle()
            checkIn = Date()
            return false
        } else if finished == false {
            finished.toggle()
            checkOut = Date()
            return true
        } else {
            return true
        }
        
    }

    func completingTask(context : NSManagedObjectContext)->Bool{
        // MARK: Updating Existing Data
        var task : Task!
        if let editTask = editTask {
            task = editTask
        }else{
            task = Task(context: context)
        }
        
        if  started == false {
            started.toggle()
            task.checkIn = Date()
            task.inStatus = getInStatus(time: task.checkIn ?? Date())
            if let _ = try? context.save(){
                return false
            }
            return false
        } else if finished == false {
            finished.toggle()
            task.checkOut = Date()
            task.outStatus = getOutStatus(time: task.checkOut ?? Date())
            if let _ = try? context.save(){
                return true
            }
            return true
        }
        
     
        
      return true
    }
    
    func getInStatus(time: Date)->Bool{
        // MARK: Updating Existing Data
        
        if (time.timeIntervalSinceReferenceDate - taskDate.timeIntervalSinceReferenceDate) > timeTolerance {
            return false
        } else {
            return true
        }
        
    }
    
    func getOutStatus(time: Date)->Bool{
            
        if (time.timeIntervalSinceReferenceDate - taskFinishTime.timeIntervalSinceReferenceDate) < timeTolerance {
            return true
        } else {
            return false
        }
            
    }
    
    func editTime() {
        resetTaskData()
        
    }
    
    
    func getCurrentWeek()->Date{
        let calendar = Calendar.current
        
        //getting current month date
        guard let currentWeek = calendar.date(byAdding: .weekOfYear, value: self.currentWeekIndex , to: Date()) else {
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
    
    
}



    
