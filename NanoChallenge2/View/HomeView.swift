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
    
    var body: some View {
       
        // MARK: Lazy Stack with Header
        LazyVStack(alignment:.leading,spacing: 15, pinnedViews: [.sectionHeaders]) {
            
            Section {
                VStack{
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
                    } .transition(.move(edge: .bottom))
                    
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            TasksView()
                           
                        }
                        
                    }.frame(maxHeight:.infinity)
                }
              
                
            }header: {
                HeaderView()
            }
            .border(.black)
            
            
        }.toTop()
        
        
        
    }
    
    // MARK: Tasks View
    func TasksView()-> some View {
        
        LazyVStack(spacing : 18){
            
            if let tasks = taskModel.filteredTasks{
                if tasks.isEmpty{
                    
                    Text("No tasks found")
                        .font(.system(size:16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }
                else{
                    
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                    }
                    
                }
            }else {
                //MARK: Progress View
                ProgressView()
                    .offset(y: 100)
            }
            
        }
        .padding()
        .padding(.top)
        // MARK: Updating Tasks
        .onChange(of: taskModel.currentDate) { newValue in
            taskModel.filterTodayTasks()
            
        }
    }
    
    // MARK: Task Card View
    func TaskCardView(task: Task)-> some View{
        
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
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
                        Text(task.taskTitle)
                            .font(.title2.bold())
                        Text(task.taskDescription)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                        
                    }
                    
                    VStack(alignment: .center, spacing: 10){
                        Text("Test")
                    }
                    .hTrailing()
                }
                
            }
            .foregroundColor(.white)
            .padding()
            .hLeading()
            .background(.black)
            .cornerRadius(25)
            
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
                Image(systemName: "plus")
                    .font(.system(size: 30))
            }
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 30))
            }
            
            
        }
        .padding()
        .background(.white)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

