//
//  NewTaskView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 27/07/22.
//

import SwiftUI

struct NewTaskView: View {
        @Namespace var animation
    
//    @Environment(\.dismiss) var dismiss
//
//    @State var taskTitle : String = ""
//    @State var taskDescription : String = ""
//    @State var taskDate: Date = Date()
//
//    // MARK: Core Data Context
//    @Environment(\.managedObjectContext) var context
    
    @Environment(\.self) var env
    
    @EnvironmentObject var taskModel : TaskViewModel
    
    var body: some View {
        
        VStack(spacing:12){
            
            Text("Create New Task")
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
                    .foregroundColor(.black)
                }
                .padding(.bottom, 20)

            
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.primary)
                
                
                TextField("Write title here", text: $taskModel.taskTitle)
                    .font(.title2)
                    .overlay(alignment: .trailing){
                        
                    }
                
                
                Divider()
                
            }
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    
                    Text($taskModel.taskDate.formatted(date : .abbreviated, time: .omitted))
                        .font(.title2)
                        .onTapGesture {
                            
                        }
                    
                    Divider()
                    
                }
                .overlay(alignment: .trailing){
                    Button{
                        
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
                    
                    
                    
                }.padding(.top, 10)
            }
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Start Time")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    
                    // MARK: Sample Card Colors
                    
                    Text($taskModel.taskDate.formatted(date : .omitted, time: .shortened))
                    
                    Divider()
                    
                }
                .frame(maxWidth : .infinity, alignment: .leading)
                .overlay(alignment: .trailing){
                    Button{
                        
                    }label: {
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.black)
                    
                    
                    
                }.padding(.trailing, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Finish Time")
                        .font(.caption)
                        .foregroundStyle(.primary)
                    
                    Text($taskModel.taskDate.formatted(date : .omitted, time: .shortened))
                    
                    Divider()
                    
                }
                .frame(maxWidth : .infinity, alignment: .leading)
                .overlay(alignment: .trailing){
                    Button{
                        
                    }label: {
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.black)
                    
                    
                    
                }.padding(.trailing, 20)
                
            }.padding(.top, 10)
            
            HStack{
                VStack {
                    Text("Check In")
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .padding(.bottom,5)
                    Text($taskModel.taskDate.formatted(date : .omitted, time: .shortened))
                    
                    Text("Failed")
                        .font(.caption)
                        .frame(width: 70, height: 15)
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                    
                }
                .foregroundColor(.white)
                .frame(maxWidth : .infinity, alignment: .center)
                
                VStack {
                    Text("Check out")
                        .font(.caption)
                        .foregroundStyle(.primary)
                        .padding(.bottom,5)
//                    Text(taskDate.formatted(date : .omitted, time: .shortened))
                    Text("--:--")
                    Text("Completed")
                        .font(.caption)
                        .frame(width: 70, height: 15)
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                }
                .foregroundColor(.white)
                .frame(maxWidth : .infinity, alignment: .center)
                
                
            }
            .padding(.vertical,10)
            .background(.gray)
            .cornerRadius(20)
            
        }
        .frame(maxHeight: .infinity, alignment : .top)
        .padding()
        .overlay{
            ZStack{
                if $taskModel.showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            $taskModel.showDatePicker = false
                        }
                    
                    // MARK: Disabling Past Dates
                    DatePicker.init("",selection: $taskModel.taskDate,in:Date.now...Date.distantFuture)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                        .padding()
                }
            }
            .animation($taskModel.showDatePicker, value: .easeInOut)
        }
        
    }
}

struct CreateNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
            .environmentObject(TaskViewModel())
    }
}
