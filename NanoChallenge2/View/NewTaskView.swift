//
//  NewTaskView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 27/07/22.
//

import SwiftUI

struct NewTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var taskTitle : String = ""
    @State var taskDescription : String = ""
    @State var taskDate: Date = Date()
    
    // MARK: Core Data Context
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var taskModel : TaskViewModel
    
    var body: some View {
        NavigationView{
            List{
                
                Section {
                    TextField("Go To Work", text: $taskTitle)
                } header : {
                    Text("Task Title")
                }
                Section {
                    TextField("Nothing", text: $taskDescription)
                } header : {
                    Text("Task Description")
                }
                Section {
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                } header : {
                    Text("Task Date")
                }
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Create New Task")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: Disballing Dismiss on Swipe
            //            .interactiveDismissDisabled()
            
            // MARK: Action Buttons
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                        // CAN BE REEDIT
                        
                        if let task = taskModel.editTask{
                            task.taskTitle = self.taskTitle
                            task.taskDescription = self.taskDescription
                        }else {
                            let task = Task(context: context)
                            task.taskTitle = self.taskTitle
                            task.taskDescription = self.taskDescription
                            task.taskDate = self.taskDate
                        }
                        
                  
                        
                        //Saving
                        try? context.save()
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "plus")
                    }).disabled(taskTitle == "" || taskDescription == "")
                    
                }
                
            }
            // Loading Task data if from Edit
            .onAppear {
                if let task = taskModel.editTask{
                    taskTitle = task.taskTitle ?? ""
                    taskDescription = task.taskDescription ?? ""
                    taskDate = task.taskDate ?? Date()
                }
            }
        }
    }
}

