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
    
    // MARK: Core Date Context
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            
            // MARK: Lazy Stack with Header
            LazyVStack(spacing: 25, pinnedViews: [.sectionHeaders]) {
                
                Section {
                    
                    // MARK: Current  Week View
                    ScrollView(.horizontal, showsIndicators: false) {
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
                    }
                    
                    
                    TasksView()
                    
                    
                } header: {
                    HeaderView()
                }
                
            }
            
        }.ignoresSafeArea(.container,edges: .top)
        
        // MARK: Add Button
            .overlay(
                Button(action: {
                    taskModel.addNewTask.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black, in: Circle())
                }).toBot()
            )
            .sheet(isPresented: $taskModel.addNewTask) {
                // Clearing Edit Data
                taskModel.editTask = nil
            } content : {
                NewTaskView()
                    .environmentObject(taskModel)
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
                Circle()
                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ?(task.isCompleted ? .green : .black) : .clear )
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                Rectangle()
                    .fill()
                    .frame(width: 3)
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
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
                                taskModel.addNewTask.toggle()
                            } label: {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .hLeading()
                    
                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
                    
                }
                
                //                // MARK: Team Members
                //                HStack(spacing: 0){
                //                    HStack(spacing: -10){
                //
                //                    }
                //                }
                
                if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
                    HStack(spacing:12
                    ){
                        
                        if !task.isCompleted{
                            // MARK: Check Button
                            Button {
                                //Updating Status
                                task.isCompleted = true
                                
                                //Saving
                                try? context.save()
                            } label: {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.black)
                                    .padding(10)
                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 10))
                            }.hTrailing()
                        }
                        Text(task.isCompleted ? "Completed" : "Mark Task as Completed")
                            .font(.system(size : task.isCompleted ? 14 : 16, weight: .light))
                            .foregroundColor(task.isCompleted ? .gray : .white)
                            .hLeading()
                        
                    }
                    .padding(.top)
                }
                
            }
            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15:0)
            .padding(.bottom,taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
            .hLeading()
            .background(
                Color(UIColor.black)
                    .cornerRadius(25)
                    .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
            )
            
            
        }
        .hLeading()
        
    }
    
    // MARK: Header
    func HeaderView()->some View {
        
        HStack(spacing: 10){
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(Date().formatted(date : .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 30))
            }
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 30))
            }
            
        }
        .padding()
        .padding(.top,getSafeArea().top)
        .background(.white)
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

