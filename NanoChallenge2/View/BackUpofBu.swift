////
////  HomeView.swift
////  NanoChallenge2
////
////  Created by Jonathan Andryana on 26/07/22.
////
//
//import SwiftUI
//
//struct TestView: View {
//    @StateObject var taskModel : TaskViewModel = TaskViewModel()
//    @Namespace var animation
//    
//   
//    
//    // MARK: Core Date Context
//    @Environment(\.managedObjectContext) var context
//    @Environment(\.self) var env
//    
//    var body: some View {
//        HeaderView()
//            .ignoresSafeArea(.container,edges: .top)
//        
//        VStack {
//            ScrollView(.vertical, showsIndicators: false){
//            VStack{
//                TasksView()
//                NewTasksView().padding(.horizontal,10)
//                Spacer()
//            }.border(.blue)
//                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment : .top)
//                Spacer()
//            }     .ignoresSafeArea(.container,edges: .top)
//        }
//
//
//        
//        
////        ScrollView(.vertical,showsIndicators: false){
//            
//   
//            //MARK: Header
////        VStack {
////
////                Text("Create New Task")
////                    .font(.title3.bold())
////                    .frame(maxWidth : .infinity)
////                    .overlay(alignment: .leading){
////                        Button {
////                            //                            taskModel.openEditTask.toggle()
////                            env.dismiss()
////                        } label: {
////                            Image(systemName: "arrow.left")
////                                .font(.title3)
////                                .foregroundColor(.black)
////                        }
////                    }
////                    .overlay(alignment: .trailing){
////                        Button("Save"){
////                            if taskModel.addTask(context: env.managedObjectContext){
////                                env.dismiss()
////                            }
////                        }
////                        .disabled(taskModel.taskTitle == "")
////                        .tint(.black)
////
////                    }
////                    .padding(.bottom, 20)
////
////
////        }
//        
//        
//            // MARK: Lazy Stack with Header
////            LazyVStack(spacing: 25, pinnedViews: [.sectionHeaders]) {
////
////
////                ScrollView(.vertical, showsIndicators: false){
////                VStack{
////                    TasksView()
////                    NewTasksView().padding(.horizontal,10)
////                    Spacer()
////                }.border(.blue)
////                        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment : .top)
////                    Spacer()
////                }     .ignoresSafeArea(.container,edges: .top)
////
////
////
////                Section {
////
////                    ScrollView(.vertical, showsIndicators: false){
////                    VStack{
////                        TasksView()
////                        NewTasksView().padding(.horizontal,10)
////                        Spacer()
////                    }.border(.blue)
////                            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment : .top)
////                        Spacer()
////                    }     .ignoresSafeArea(.container,edges: .top)
////
////
////
////
////                }
////                header: {
////                    HeaderView()
////                }
////
////            }
////            .ignoresSafeArea(.container,edges: .top)
////            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment : .top)
//
//            
////        }.ignoresSafeArea(.container,edges: .top)
//        
//        // MARK: Floating Add Button
//        //            .overlay(
//        //                Button(action: {
//        //                    taskModel.addNewTask.toggle()
//        //                }, label: {
//        //                    Image(systemName: "plus")
//        //                        .foregroundColor(.white)
//        //                        .padding()
//        //                        .background(Color.black, in: Circle())
//        //                }).toBot()
//        //            )
//            .sheet(isPresented: $taskModel.addNewTask) {
//                // Clearing Edit Data
//                taskModel.resetTaskData()
////                taskModel.editTask = nil
//            } content : {
//                NewTaskView()
//                    .environmentObject(taskModel)
//            }
//            .sheet(isPresented: $taskModel.openEditTask) {
//                taskModel.resetTaskData()
//            } content : {
//                NewTaskView()
//                    .environmentObject(taskModel)
//            }
//        
//    }
//    
//    // MARK: Tasks View
//    func TasksView()-> some View {
//        
//        LazyVStack(spacing : 18){
//            
//            // Converting object as Task Model
//            DynamicFilterView(dateToFilter: taskModel.currentDate) {
//                (object : Task) in
//                
//                TaskCardView(task: object)
//            }
//        }
//        .padding()
//        .padding(.top)
//        
//    }
//    
//    // MARK: Task Card View
//    func TaskCardView(task: Task)-> some View{
//        
//        HStack(alignment: .top, spacing: 30){
//            VStack(spacing: 10){
//                Text("12:30")
//                    .font(.system(size:14))
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: 50)
//                    .foregroundColor(.white)
//                    .background(.green)
//                    .cornerRadius(20)
//                //                Circle()
//                //                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ?(task.isCompleted ? .green : .black) : .clear )
//                //                    .frame(width: 15, height: 15)
//                //                    .background(
//                //                        Circle()
//                //                            .stroke(.black,lineWidth: 1)
//                //                            .padding(-3)
//                //                    )
//                //                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
//                Rectangle()
//                    .fill()
//                    .frame(width: 3)
//                
//                //                Circle()
//                //                    .fill(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ?(task.isCompleted ? .green : .black) : .clear )
//                //                    .frame(width: 15, height: 15)
//                //                    .background(
//                //                        Circle()
//                //                            .stroke(.black,lineWidth: 1)
//                //                            .padding(-3)
//                //                    )
//                //                    .scaleEffect(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
//                Text("15:00")
//                    .font(.system(size:14))
//                    .fontWeight(.semibold)
//                
//                
//                //                Circle()
//                //                    .fill(.black)
//                //                    .frame(width: 15, height: 15)
//                //                    .background(
//                //                        Circle()
//                //                            .stroke(.black,lineWidth: 1)
//                //                            .padding(-3)
//                //                    )
//            }
//            
//            VStack{
//                HStack(alignment: .top, spacing: 10) {
//                    
//                    VStack(alignment: .leading, spacing: 12){
//                        Text(task.taskTitle ?? "")
//                            .font(.title2.bold())
//                        Text(task.taskDescription ?? "")
//                            .font(.callout)
//                            .foregroundStyle(.secondary)
//                        
//                        if(task.taskDate ?? Date() ) >= Date(){
//                            Button {
//                                taskModel.editTask = task
//                                taskModel.openEditTask.toggle()
//                            } label: {
//                                Image(systemName: "pencil.circle")
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                    .hLeading()
//                    
//                    Text(task.taskDate?.formatted(date: .omitted, time: .shortened) ?? "")
//                    
//                }
//                Spacer()
//                
//                
//                if taskModel.isCurrentHour(date: task.taskDate ?? Date()){
//                    HStack(spacing:12
//                    ){
//                        
//                        
//                        // MARK: Completed Text
//                        Text(task.isCompleted ? "Completed" : "")
//                            .font(.system(size : task.isCompleted ? 14 : 16, weight: .light))
//                            .foregroundColor(task.isCompleted ? .gray : .white)
//                            .hLeading()
//                        
//                        if !task.isCompleted{
//                            // MARK: Check Button
//                            Button {
//                                //Updating Status
//                                task.isCompleted.toggle()
//                                
//                                //Saving
//                                try? env.managedObjectContext.save()
//                            } label: {
//                                Image(systemName: "checkmark")
//                                    .foregroundStyle(.black)
//                                    .padding(10)
//                                    .background(Color.white,in: RoundedRectangle(cornerRadius: 10))
//                            }.hTrailing()
//                        }
//                        
//                    }
//                    .hTrailing()
//                    
//                }
//                
//            }
////            .fullScreenCover(isPresented: $taskModel.addNewTask) {
////                taskModel.resetTaskData()
////
////            } content : {
////                NewTaskView().environmentObject(taskModel)
////            }
////            .foregroundColor(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
////            .padding(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 15:0)
////            .padding(.bottom,taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 0 : 10)
////            .hLeading()
////            .background(
////                Color(UIColor.black)
////                    .cornerRadius(25)
////                    .opacity(taskModel.isCurrentHour(date: task.taskDate ?? Date()) ? 1 : 0)
////            )
////
//            
//        }
//        .hLeading()
//        
//        
//    }
//    
//    // MARK: Header
//    func HeaderView()->some View {
//        VStack {
//        HStack(spacing: 10){
//            
//            VStack(alignment: .leading, spacing: 10) {
//                
//                Text(Date().formatted(date : .abbreviated, time: .omitted))
//                    .foregroundColor(.gray)
//                
//                Text(Date().formatted(date : .abbreviated, time: .omitted))
//                    .font(.largeTitle.bold())
//                
//                
//            }
//            .hLeading()
//            
//            Button {
//                taskModel.addNewTask.toggle()
//            } label: {
//                Image(systemName: "plus")
//                    .tint(.black)
//                    .font(.system(size: 30))
//            }
//            
//        }
//        .padding()
//        .padding(.bottom,10)
//        .padding(.top,getSafeArea().top)
//        .background(.red)
//        .cornerRadius(30)
//            
//
//        }
//    }
//    
//    // MARK: TaskView
//    @ViewBuilder
//    func NewTasksView()->some View{
//        LazyVStack(spacing: 20){
//            DynamicFilterView(dateToFilter: taskModel.currentDate) {
//                (object : Task) in
//                
//                TaskRowView(task: object)
//            }
//            
//        }
//        .padding(.top,20)
//    }
//    
//    // MARK: Task Row View
//    @ViewBuilder
//    func TaskRowView(task: Task)->some View {
//        VStack(alignment:.leading, spacing: 10){
//            HStack{
//                Text("11:00 AM - 12:00 AM")
//                    .font(.system(size:14))
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
////                    .background(.green)
//                    .cornerRadius(20)
////                    .font(.callout)
//                    .padding(.vertical,5)
//                    .padding(.horizontal)
//                    .background{
//                        Capsule()
//                            .fill(.gray.opacity(0.3))
//                    }
//                
//
//                Spacer()
//                
//               //  MARK: Edit Button Only for Non Completed Tasks
//                if !task.isCompleted{
//                    Button{
//                        taskModel.editTask = task
//                        taskModel.openEditTask = true
//                        taskModel.setupTask()
//                    }label: {
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.white)
//                    }
//
//                }
//            }
//            .hLeading()
//            
//            Text(task.taskTitle ?? "")
//                .font(.title2.bold())
//                .foregroundColor(.white)
//                .padding(.vertical,10)
//            
//        }
//        .padding()
//        .frame(maxWidth:.infinity)
//        .background{
//            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                .fill(.black)
//        }
//    }
//        
//}
//
//
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
//
