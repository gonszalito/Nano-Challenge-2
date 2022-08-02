//
//  HomeView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var taskModel : TaskViewModel = TaskViewModel()
    @Namespace var animation
    
    // MARK: Animation Properties
    @State var animatedStates : [Bool] = Array(repeating: false, count: 3)
    
    @State private var index = 2
    
    // MARK: Core Date Context
    @Environment(\.managedObjectContext) var context
    @Environment(\.self) var env
    
    var body: some View {
        
        VStack {
            
            VStack {
                HStack(spacing: 10){
                    VStack(alignment: .leading) {
                        
                        
                        // MARK: Title and plus
                        
                        Text(Date().formatted(date : .abbreviated, time: .omitted))
                            .font(.title.bold())
                            .tint(.black)
                            .hLeading()
                        
                        
                        
                    }
                    .hLeading()
                    
                    HStack {
                        
                        Button {
                            if !animatedStates[0] {
                                startAnimation()
                            }else{
                                stopAnimation()
                            }
                            
                            
                        } label: {
                            Image(systemName: "calendar")
                                .tint(.black)
                                .font(.system(size: 28))
                                .ignoresSafeArea()
                            
                            
                        }  .frame(maxWidth:.infinity, alignment: .leading)
                        
                        
                        Button {
                            taskModel.fetchPreviousWeek()
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(.black)
                                .font(.system(size: 28))
                        }.hLeading()
                        
                        
                        
                        Button {
                            taskModel.fetchNextWeek()
                        } label: {
                            Image(systemName: "chevron.right")
                                .tint(.black)
                                .font(.system(size: 28))
                        }.hLeading()
                        
                        Button {
                            taskModel.addNewTask.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .tint(.black)
                                .font(.system(size: 28))
                        }
                    }
                    .hTrailing()
                }
                .padding()
                .padding(.bottom,10)
                .padding(.top,getSafeArea().top)
                .cornerRadius(30)
                
                .frame(height: 100)
                
                // MARK: Week View
                ZStack{
                    HStack(spacing : 10){
                        
                        
                        
                        ForEach(taskModel.currentWeek,id: \.self) { day in

                            VStack(spacing : 10){
                                Text(taskModel.extractDate(date: day, format: "EEE"))
                                    .font(.system(size:14))
                                    .fontWeight(.semibold)

                                Text(taskModel.extractDate(date: day, format: "dd"))
                                    .font(.system(size:14))

                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                                    .opacity(taskModel.isToday(date: day) ? 1 : 0)
                            }
                            // MARK: Foreground Style
                            .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                            .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                            // MARK: Capsule Shape
                            .frame(width: 45, height: 90)
                            .background(
                                ZStack{
                                    // MARK:
                                    if taskModel.isToday(date: day){
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                    }


                                }
                            )
                            .contentShape(Capsule())
                            .onTapGesture {
                                // Updating Current Day
                                withAnimation{
                                    taskModel.currentDate = day
                                }
                            }

                        }
                        
                    }
                    .opacity(animatedStates[0] ? 0 : 1)
                    .background(
                        Rectangle()
                            .fill(.clear)
                            .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    if animatedStates[0]{
                        
                        
//                           VStack{
//                               TabView(selection: $index) {
//                                   ForEach($taskModel.dateValues.count,id: \.self){_ in
//                                       Text("print")
//                                   }
//                               }
//                               .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                        // MARK: Home View
//                        DatePicker.init("",selection: $taskModel.currentDate,displayedComponents: [.date])
//                            .datePickerStyle(.graphical)
////
//                            .background(
//                                RoundedRectangle(cornerRadius: 30,style: .continuous)
//                                    .fill(.clear)
//                                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
//                            )
//                            .onChange(of: taskModel.currentDate, perform: { _ in
//                                taskModel.fetchWeek()
//                        })
                        
//                        CustomDatePicker( taskModel: taskModel, currentDate: $taskModel.currentDate)
                        
                        CustomWeekView(taskModel: self.taskModel, currentDate: $taskModel.currentDate)
                    }
                    
                    
                }
                
                ScrollView(.vertical,showsIndicators: false) {
                    VStack{
                        NewTasksView().padding(.horizontal,10)
                    }
                }
            }
            .ignoresSafeArea(.container,edges: .top)
            .frame(maxHeight : .infinity, alignment: .top)
            .sheet(isPresented: $taskModel.addNewTask) {
                // Clearing Edit Data
                taskModel.resetTaskData()
                //                taskModel.editTask = nil
            } content : {
                NewTaskView()
                    .environmentObject(taskModel)
            }
            .sheet(isPresented: $taskModel.openEditTask) {
                taskModel.resetTaskData()
            } content : {
                NewTaskView()
                    .environmentObject(taskModel)
            }
        }
    }
    
    
    
    func WeekCardView(week : [Date])->some View{
        HStack{
            
            ZStack {
                ForEach(week,id: \.self) { day in
                    
                    VStack(spacing : 10){
                        Text(taskModel.extractDate(date: day, format: "EEE"))
                            .font(.system(size:14))
                            .fontWeight(.semibold)
                        
                        Text(taskModel.extractDate(date: day, format: "dd"))
                            .font(.system(size:14))
                        
                    }
                    // MARK: Foreground Style
                    .foregroundStyle(taskModel.isToday(date: day) ? .primary : .secondary)
                    .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                    // MARK: Capsule Shape
                    .frame(width: 45, height: 90)
                    .background(
                        ZStack{
                            // MARK:
                            if taskModel.isToday(date: day){
                                Capsule()
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                            }
                            
                            
                        }
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        // Updating Current Day
                        withAnimation{
                            taskModel.currentDate = day
                        }
                    }
                    
                }
                .frame(maxWidth : .infinity)
                .border(.blue)
            }
        }
    }
    
    
    // MARK: Tasks View
    func TasksView()-> some View {
        
        LazyVStack(spacing : 18){
            
            // Converting object as Task Model
            DynamicFilterView(dateToFilter: taskModel.currentDate) {
                (object : Task) in
                
                TaskCardView(task: object)
            }
        }
        .padding()
        .padding(.top)
        
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task)-> some View{
        
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Text("12:30")
                    .font(.system(size:14))
                    .fontWeight(.semibold)
                    .frame(maxWidth: 50)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(20)
                
                Rectangle()
                    .fill()
                    .frame(width: 3)
                
                Text("15:00")
                    .font(.system(size:14))
                    .fontWeight(.semibold)
                
                
                
            }
            
            VStack{
                HStack(alignment: .top, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.taskTitle ?? "")
                            .font(.title2.bold())
                        Text(task.taskDescription ?? "")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                        if(task.taskDate ?? Date() ) >= Date(){
                            Button {
                                taskModel.editTask = task
                                taskModel.openEditTask.toggle()
                            } label: {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .hLeading()
                    
                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                    
                }
                Spacer()
                
                
                if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
                    HStack(spacing:12
                    ){
                        
                        
                        // MARK: Completed Text
                        Text(task.isCompleted ? "Completed" : "")
                            .font(.system(size : task.isCompleted ? 14 : 16, weight: .light))
                            .foregroundColor(task.isCompleted ? .gray : .white)
                            .hLeading()
                        
                        if !task.isCompleted{
                            // MARK: Check Button
                            Button {
                                
                                
                                //Saving
                                try? env.managedObjectContext.save()
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .padding(10)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 10))
                            }.hTrailing()
                        }
                        
                    }
                    .hTrailing()
                    
                }
                
            }
            
            
        }
        .hLeading()
        
        
    }
    
    // MARK: Header
    func HeaderView()->some View {
        VStack {
            HStack(spacing: 10){
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(Date().formatted(date : .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                    
                    Text(Date().formatted(date : .abbreviated, time: .omitted))
                        .font(.largeTitle.bold())
                    
                    
                }
                .hLeading()
                
                
                
            }
            .padding()
            .padding(.bottom,10)
            .padding(.top,getSafeArea().top)
            .cornerRadius(30)
            
            
        }
        
    }
    
    // MARK: TaskView
    @ViewBuilder
    func NewTasksView()->some View{
        LazyVStack(spacing: 20){
            DynamicFilterView(dateToFilter: taskModel.currentDate) {
                (object : Task) in
                
                TaskRowView(task: object)
            }
            
        }
        .padding(.top,20)
    }
    
    // MARK: Task Row View
    @ViewBuilder
    func TaskRowView(task: Task)->some View {
        VStack(alignment:.leading, spacing: 10){
            HStack{
                Text("\(task.taskDate!, style: .time) - \(task.taskFinishTime!, style: .time) ")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background(
                        
                        Capsule()
                            .foregroundColor(.gray.opacity(0.3))
                        
                    )
                
            }.hCenter()
            
            HStack{
                
                Text(task.taskTitle ?? "")
                    .font(.title2.bold())
                    .foregroundColor(.black)
                    .padding(.vertical,10)
                
                Spacer()
                
            }
            
            
            
            
            HStack {
                
                VStack {
                    if let checkIn = task.checkIn {
                        Text("In : \(checkIn, style: .time)")
                        
                            .font(.system(size:14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.vertical,5)
                            .frame(maxWidth:.infinity)
                            .background{
                                Capsule()
                                    .fill(task.inStatus ? Color("LightGreen") : Color("LightRed")  )
                            }
                        
                        
                    }
                    
                    
                }
                .frame(maxWidth:.infinity)
                
                VStack {
                    if let checkOut = task.checkOut {
                        Text("Out  : \(checkOut, style: .time)")
                        
                            .font(.system(size:14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.vertical,5)
                            .frame(maxWidth:.infinity)
                            .background{
                                Capsule()
                                Capsule()
                                    .fill(task.outStatus ? Color("LightGreen") : Color("LightRed")  )
                            }
                        
                    }
                }
                .frame(maxWidth:.infinity)
                
                if !task.isCompleted{
                    
                    Button {
                        //Updating Status
                        taskModel.editTask = task
                        
                        if taskModel.completingTask(context: env.managedObjectContext){
                            task.isCompleted.toggle()
                            taskModel.resetTaskData()
                        }
                        
                        
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                
                                
                            )
                    }.hTrailing()
                }
            }
            .frame(alignment: .center)
            
            
            
        }
        
        .padding()
        .frame(maxWidth:.infinity)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .foregroundColor(Color("LightBlue"))
                .shadow( radius: 4, x: 3, y: 4)
            
        }
        .onTapGesture {
            taskModel.editTask = task
            taskModel.openEditTask = true
            taskModel.setupTask()
            
        }
    }
    
    
    
    func startAnimation(){
        // MARK: Displaying Splash Icon for Some Time
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            // your code here
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                animatedStates[0] = true
            }
        }
        
        
        
    }
    
    
    func stopAnimation(){
        // MARK: Displaying Splash Icon for Some Time
        
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
            // your code here
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                animatedStates[0] = false
            }
        }
        
        
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

