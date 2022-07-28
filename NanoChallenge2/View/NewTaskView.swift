//
//  NewTaskView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 27/07/22.
//

import SwiftUI

struct NewTaskView: View {
    @EnvironmentObject var taskModel : TaskViewModel
    
    @Environment(\.self) var env
    
    @Namespace var animation
    
    var body: some View {
        
        VStack(spacing: 12){
            
            // MARK: Header View
            VStack {
                if taskModel.addNewTask {
                    Text("Create New Task")
                        .font(.title3.bold())
                        .frame(maxWidth : .infinity)
                        .overlay(alignment: .leading){
                            Button {
                                //                            taskModel.openEditTask.toggle()
                                env.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        .overlay(alignment: .trailing){
                            Button("Save"){
                                if taskModel.addTask(context: env.managedObjectContext){
                                    env.dismiss()
                                }
                            }
                            .disabled(taskModel.taskTitle == "")
                            .tint(.black)
                            
                        }
                        .padding(.bottom, 20)
                } else {
                    Text("Edit Task")
                        .font(.title3.bold())
                        .frame(maxWidth : .infinity)
                        .overlay(alignment: .leading){
                            Button {
                                env.dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                        }
                        .overlay(alignment: .trailing){
                            Button("Save"){
                                if taskModel.addTask(context: env.managedObjectContext){
                                    env.dismiss()
                                }
                            }
                            .disabled(taskModel.taskTitle == "")
                            .tint(.black)
                            
                        }
                        .padding(.bottom, 20)
                }
             
            }
            
            // MARK: Body View
            VStack{
                
                // MARK: Task Title
                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Title")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    
                    TextField("Write title here", text: $taskModel.taskTitle)
                        .font(.title2.bold())
                        .overlay(alignment: .trailing){
                            
                        }
                    Divider()
                }
                .padding(.top,10)
                
                // MARK: Date
                VStack(alignment: .leading, spacing: 12) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    
                    
                    HStack {
                        Text(taskModel.taskDate.formatted(date : .abbreviated, time: .omitted))
                            .font(.title2.bold())
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                taskModel.showDatePicker.toggle()
                        }
                        
                        // MARK: PopUp Date Picker
//                        Spacer()
//
//                        ZStack {
//                            DatePicker("label", selection: $taskModel.taskDate, displayedComponents: [.date])
//                                .datePickerStyle(CompactDatePickerStyle())
//                                .labelsHidden()
//                                .hTrailing()
//                            Image(systemName: "calendar")
//                                .resizable()
//                                .frame(width: 32, height: 32, alignment: .trailing)
//                                .userInteractionDisabled()
//                                .border(.red)
//                        }
//                        .frame(width: 32, height: 32, alignment: .trailing)
//                        .border(.blue)
                        
                        
                    }
                    
                    Divider()
                    
                }
                .overlay(alignment: .trailing){
                    Button{
                        UIApplication.shared.endEditing()
                        taskModel.showDatePicker.toggle()
                        
                    }label: {
                        Image(systemName: "calendar")
                    }
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(
                        ZStack{
                            Circle()
                                .fill(.black)
                        })
                 
                    
                }
                .padding(.top,10)
                
                // MARK: Start - End Time
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Start Time")
                            .font(.caption)
                            .foregroundStyle(.primary)
                        
                        
                        // MARK: Sample Card Colors
                        
                        Text(taskModel.taskDate.formatted(date : .omitted, time: .shortened))
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                taskModel.showStartPicker.toggle()
                                
                            }
                        
                        
                        
                        Divider()
                        
                    }
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .overlay(alignment: .trailing){
                        Button{
                            UIApplication.shared.endEditing()
                            taskModel.showStartPicker.toggle()
                        }label: {
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.black)
                        
                        
                        
                    }.padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Finish Time")
                            .font(.caption)
                            .foregroundStyle(.primary)
                        
                        Text(taskModel.taskFinishTime.formatted(date : .omitted, time: .shortened))
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                taskModel.showFinishPicker.toggle()
                                
                                
                            }
                        
                        Divider()
                        
                    }
                    .frame(maxWidth : .infinity, alignment: .leading)
                    .overlay(alignment: .trailing){
                        Button{
                            UIApplication.shared.endEditing()
                            taskModel.showFinishPicker.toggle()
                            
                            
                        }label: {
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.black)
                        
                        
                        
                    }.padding(.trailing, 20)
                    
                }.padding(.top, 10)
                
            }
            
            // MARK: Edit Buttons
            
            HStack{
                Button("Set Time"){
                    
                }
                .opacity(taskModel.editTask == nil ? 0 : 1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .tint(.white)
                .background(
                    ZStack{
                        Rectangle()
                            .fill(taskModel.editTask == nil ? .clear : .orange)
                            .cornerRadius(20)
                    }
                    
                )
                Button {
                    
                }label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(.red)
                        )
                }
                
                Button("Delete"){
                    if let editTask = taskModel.editTask {
                        env.managedObjectContext.delete(editTask)
                        try? env.managedObjectContext.save()
                        env.dismiss()
                    }
                }
                .opacity(taskModel.editTask == nil ? 0 : 1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .tint(.white)
                .background(
                    ZStack{
                        Rectangle()
                            .fill(taskModel.editTask == nil ? .clear : .red)
                            .cornerRadius(20)
                    }
                    
                )
                
       
                
            }.hBot()
            
            //            HStack{
            //                VStack {
            //                    Text("Check In")
            //                        .font(.caption)
            //                        .foregroundStyle(.primary)
            //                        .padding(.bottom,5)
            //                    Text($taskModel.taskDate.formatted(date : .omitted, time: .shortened))
            //
            //                    Text("Failed")
            //                        .font(.caption)
            //                        .frame(width: 70, height: 15)
            //                        .padding()
            //                        .background(.green)
            //                        .cornerRadius(20)
            //
            //                }
            //                .foregroundColor(.white)
            //                .frame(maxWidth : .infinity, alignment: .center)
            //
            //                VStack {
            //                    Text("Check out")
            //                        .font(.caption)
            //                        .foregroundStyle(.primary)
            //                        .padding(.bottom,5)
            ////                    Text(taskDate.formatted(date : .omitted, time: .shortened))
            //                    Text("--:--")
            //                    Text("Completed")
            //                        .font(.caption)
            //                        .frame(width: 70, height: 15)
            //                        .padding()
            //                        .background(.green)
            //                        .cornerRadius(20)
            //                }
            //                .foregroundColor(.white)
            //                .frame(maxWidth : .infinity, alignment: .center)
            //
            //
            //            }
            //            .padding(.vertical,10)
            //            .background(.gray)
            //            .cornerRadius(20)
            //
            //        }
            //        .frame(maxHeight: .infinity, alignment : .top)
            //        .padding()
            
            
        }
        .frame(maxHeight: .infinity, alignment : .top)
        .padding()
        .overlay{
            
            // MARK: Date Picker
            ZStack{
                if taskModel.showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            taskModel.showDatePicker = false
                        }
                    
                    // MARK: Disabling Past Dates
                    DatePicker.init("",selection: $taskModel.taskDate,in:Date.now...Date.distantFuture,displayedComponents: [.date])
                        .onChange(of: taskModel.taskDate, perform: { _ in
                            taskModel.showDatePicker = false
                        })
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                        .padding()
            
                }
            }
            .animation(.easeInOut, value: taskModel.showDatePicker)
            
            // MARK: Start Time Picker
            ZStack{
                if taskModel.showStartPicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            taskModel.changeTime()
                            taskModel.showStartPicker = false
                            
                        }
                    
                    // MARK: Disabling Past Dates
                    DatePicker.init("",selection: $taskModel.taskDate ,in:Date.now...Date.distantFuture,displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                        .padding()
                    
                    
                }
            }
            .animation(.easeInOut, value: taskModel.showStartPicker)
            
            // MARK: Finish Time Picker
            ZStack{
                if taskModel.showFinishPicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            taskModel.showFinishPicker = false
                        }
                    
                    // MARK: Disabling Past Dates
                    DatePicker.init("",selection: $taskModel.taskFinishTime ,in:taskModel.taskDate...Date.distantFuture,displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                        .padding()
                    
                }
                 
            }
           
            .animation(.easeInOut, value: taskModel.showFinishPicker)
            
        }
        
    }
    
}
struct CreateNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
            .environmentObject(TaskViewModel())
    }
}
