//
//  HomeView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 26/07/22.
//

import SwiftUI

struct TestView: View {
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
                        
                        //                Text(Date().formatted(date : .abbreviated, time: .omitted))
                        //                    .foregroundColor(.gray)
                        
                        // MARK: Title and plus
                        //                        Button {
                        //
                        //                        } label: {
                        Text(Date().formatted(date : .abbreviated, time: .omitted))
                            .font(.title.bold())
                            .tint(.black)
                        //                        }
                        
                        //                                                ZStack {
                        //                                                    DatePicker("label", selection: $taskModel.taskDate, displayedComponents: [.date])
                        //                                                        .datePickerStyle(CompactDatePickerStyle())
                        //                                                        .labelsHidden()
                        //                                                        .hTrailing()
                        //                                                    Button {
                        //
                        //                                                    } label: {
                        //                                                        Text(Date().formatted(date : .abbreviated, time: .omitted))
                        //                                                            .font(.title.bold())
                        //                                                            .tint(.black)
                        //                                                    }
                        //                                                        .userInteractionDisabled()
                        //                                                        .border(.red)
                        //                                                }
                        //                                                .frame(width: 32, height: 32, alignment: .trailing)
                        //
                        //
                        
                        
                    }
                    //                    .frame(alignment: .center)
                    .hLeading()
                    
                    Button {
                        stopAnimation()

                        
                    } label: {
                        Image(systemName: "circle")
                            .tint(.black)
                            .font(.system(size: 28))
                            .ignoresSafeArea()
                        
                   
                    }
                    
                    Button {
                        startAnimation()
                        
                    } label: {
                        Image(systemName: "calendar")
                            .tint(.black)
                            .font(.system(size: 28))
                            .ignoresSafeArea()
                        
                   
                    }
                    
                    Button {
                        taskModel.fetchPreviousWeek()
                    } label: {
                        Image(systemName: "circle")
                            .tint(.black)
                            .font(.system(size: 28))
                    }
                    
                    Button {
                        taskModel.fetchNextWeek()
                    } label: {
                        Image(systemName: "pencil")
                            .tint(.black)
                            .font(.system(size: 28))
                    }
                    
                    Button {
                        taskModel.addNewTask.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .tint(.black)
                            .font(.system(size: 28))
                    }
                    
                }
                .padding()
                .padding(.bottom,10)
                .padding(.top,getSafeArea().top)
                //                .background(.red)
                .cornerRadius(30)
//                WeekCardView(week: taskModel.previousWeek)

//                          .onChange(of: taskModel.allWeeks, perform: <#T##(Equatable) -> Void##(Equatable) -> Void##(_ newValue: Equatable) -> Void#>)
                .frame(height: 100)
                
//                VStack{
//                    TabView(selection: $taskModel.weekIndex) {
//                        ForEach(taskModel.allWeeks, id: \.self) { week in
//                            HStack{
//                              WeekCardView(week: week)
//                                  .tag(week)
//                            }
//                          }
//                    }
//                    .frame(height: 100, alignment: .center)
//                                      .onChange(of: taskModel.weekIndex) { _ in
//                  //                        taskModel.refreshWeek()}
//                  //                        if taskModel.currentWeek == taskModel.nextWeek {
//                                      }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                }
                                     
//                VStack {
//                    TabView(selection: $taskModel.weekIndex) {
////                        WeekCardView(week: taskModel.previousWeek)
////                                .tag(1)
////                                .border(.blue)
////
////                        WeekCardView(week: taskModel.currentWeek)
////                                .tag(2)
////
////                        WeekCardView(week: taskModel.nextWeek)
////                                .tag(3)
//
//                        ForEach(taskModel.arrAll, id: \.self) { week in
//
//                            WeekCardView(week: week)
////                                .tag(week)
//
//                        }
//
////
//                    }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                    .frame(height: 100, alignment: .center)
//                }
//                    .onChange(of: taskModel.weekIndex) { _ in
////                        taskModel.refreshWeek()
////                        if taskModel.currentWeek == taskModel.nextWeek {
////                            taskModel.weekIndex = 2
////                        }
////                        taskModel.weekIndex = 2
////
////                        if taskModel.weekIndex != 2 {
////                            withAnimation {
////                                taskModel.weekIndex = 2
////                            }
////                        }
////                        if taskModel.weekIndex == 3 {
////                            taskModel.weekIndex = 2
////                        } else if taskModel.weekIndex == 1 {
////                            taskModel.weekIndex = 2
////                        }
//                }
//                }.border(.black)
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                        .accentColor(.orange)
//                        .onChange(of: selectedItem) { value in print("selected tab = \(value)") }
                
//                TabView(selection: $index) {
//                    ForEach(taskModel.allWeeks, id: \.self) { week in
//                             WeekCardView(week: week)
////                        CardView()
//
//                         }
//
//                     }
//                     .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                     
                
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
                
                .background(
                    Rectangle()
                        .fill(.clear)
                        .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                
                    
                    if animatedStates[0]{
                        // MARK: Home View
                        CustomDatePicker( taskModel: taskModel, currentDate: $taskModel.currentDate)
                            .background(
                                RoundedRectangle(cornerRadius: 30,style: .continuous)
                                    .fill(Color.red)
                                    .matchedGeometryEffect(id: "DATEVIEW", in: animation)
                            )
                    }
                    
          
                }
//                DatePicker.init("",selection: $taskModel.taskDate,displayedComponents: [.date])
//                    .onChange(of: taskModel.taskDate, perform: { _ in
////                        taskModel.showDatePicker = false
//                    })
//                    .datePickerStyle(.graphical)
//                    .labelsHidden()
//                    .padding()
//                    .background(.white, in: RoundedRectangle(cornerRadius: 12,style: .continuous))
//                    .padding()
//
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
                        
    //                    Circle()
    //                        .fill(.white)
    //                        .frame(width: 8, height: 8)
    //                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
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
                //                Circle()
                //                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ?(task.isCompleted ? .green : .black) : .clear )
                //                    .frame(width: 15, height: 15)
                //                    .background(
                //                        Circle()
                //                            .stroke(.black,lineWidth: 1)
                //                            .padding(-3)
                //                    )
                //                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                Rectangle()
                    .fill()
                    .frame(width: 3)
                
                //                Circle()
                //                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ?(task.isCompleted ? .green : .black) : .clear )
                //                    .frame(width: 15, height: 15)
                //                    .background(
                //                        Circle()
                //                            .stroke(.black,lineWidth: 1)
                //                            .padding(-3)
                //                    )
                //                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                Text("15:00")
                    .font(.system(size:14))
                    .fontWeight(.semibold)
                
                
                //                Circle()
                //                    .fill(.black)
                //                    .frame(width: 15, height: 15)
                //                    .background(
                //                        Circle()
                //                            .stroke(.black,lineWidth: 1)
                //                            .padding(-3)
                //                    )
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
                                //Updating Status
                                task.isCompleted.toggle()
                                
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
            //            .fullScreenCover(isPresented: $taskModel.addNewTask) {
            //                taskModel.resetTaskData()
            //
            //            } content : {
            //                NewTaskView().environmentObject(taskModel)
            //            }
            //            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
            //            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15:0)
            //            .padding(.bottom,taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
            //            .hLeading()
            //            .background(
            //                Color(UIColor.black)
            //                    .cornerRadius(25)
            //                    .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
            //            )
            //
            
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
            //            .background(.red)
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
                Text("11:00 AM - 12:00 AM")
                    .font(.system(size:14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                //                    .background(.green)
                    .cornerRadius(20)
                //                    .font(.callout)
                    .padding(.vertical,5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.gray.opacity(0.3))
                    }
                
                
                Spacer()
                
                //  MARK: Edit Button Only for Non Completed Tasks
                if !task.isCompleted{
                    Button{
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                    }
                    
                }
            }
            .hLeading()
            
            Text(task.taskTitle ?? "")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.vertical,10)
            
        }
        .padding()
        .frame(maxWidth:.infinity)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.black)
        }
    }
    
    
    func startAnimation(){
        // MARK: Displaying Splash Icon for Some Time
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                animatedStates[0] = true
            }
        }
        
        
        
//        DispatchQueue.main.asyncAfter() {
//            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
//                animatedStates[0]
//            }
//        }
    }
    
    
    func stopAnimation(){
        // MARK: Displaying Splash Icon for Some Time
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                animatedStates[0] = false
            }
        }
        
        
        
//        DispatchQueue.main.asyncAfter() {
//            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
//                animatedStates[0]
//            }
//        }
    }
    
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

