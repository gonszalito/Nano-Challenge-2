////
////  NewTaskView.swift
////  NanoChallenge2
////
////  Created by Jonathan Andryana on 27/07/22.
////
//
//import SwiftUI
//
//struct NewTaskView: View {
//
//    @Environment(\.dismiss) var dismiss
//
//    @State var taskTitle : String = ""
//    @State var taskDescription : String = ""
//    @State var taskDate: Date = Date()
//
//    // MARK: Core Data Context
//    @Environment(\.managedObjectContext) var context
//
//    @EnvironmentObject var taskModel : TaskViewModel
//
//    var body: some View {
//
//        VStack(spacing:12){
//
//            Text("Create New Task")
//                .font(.title3.bold())
//                .frame(maxWidth : .infinity)
//                .overlay(alignment: .leading){
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "arrow.left")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                    }
//                }.padding(.bottom,20)
//
//
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Task Title")
//                    .font(.caption)
//                    .foregroundStyle(.primary)
//
//
//                TextField("Write title here", text: $taskTitle)
//                    .font(.title2)
//                    .overlay(alignment: .trailing){
//
//                    }
//
//
//                Divider()
//
//            }
//            HStack {
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Date")
//                        .font(.caption)
//                        .foregroundStyle(.primary)
//
//
//                    Text(taskDate.formatted(date : .abbreviated, time: .omitted))
//                        .font(.title2)
//                        .onTapGesture {
//
//                        }
//
//                    Divider()
//
//                }
//                .overlay(alignment: .trailing){
//                    Button{
//
//                    }label: {
//                        Image(systemName: "calendar")
//                    }
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(.white)
//                    .background(
//                        ZStack{
//                            Circle()
//                                .fill(.black)
//                        })
//
//
//
//                }.padding(.top, 10)
//            }
//            HStack {
//                VStack(alignment: .leading, spacing: 12) {
//
//                    Text("Start Time")
//                        .font(.caption)
//                        .foregroundStyle(.primary)
//
//
//                    // MARK: Sample Card Colors
//
//                    Text(taskDate.formatted(date : .omitted, time: .shortened))
//
//                    Divider()
//
//                }
//                .frame(maxWidth : .infinity, alignment: .leading)
//                .overlay(alignment: .trailing){
//                    Button{
//
//                    }label: {
//                        Image(systemName: "chevron.down")
//                    }
//                    .foregroundColor(.black)
//
//
//
//                }.padding(.trailing, 20)
//
//                VStack(alignment: .leading, spacing: 12) {
//
//                    Text("Finish Time")
//                        .font(.caption)
//                        .foregroundStyle(.primary)
//
//                    // MARK: Sample Card Colors
//
//                    Text(taskDate.formatted(date : .omitted, time: .shortened))
//
//                    Divider()
//
//                }
//                .frame(maxWidth : .infinity, alignment: .leading)
//                .overlay(alignment: .trailing){
//                    Button{
//
//                    }label: {
//                        Image(systemName: "chevron.down")
//                    }
//                    .foregroundColor(.black)
//
//
//
//                }.padding(.trailing, 20)
//
//            }.padding(.top, 10)
//
//            HStack{
//                VStack {
//                    Text("Check In")
//                        .font(.caption)
//                    .foregroundStyle(.primary)
//                }
//                .frame(maxWidth : .infinity, alignment: .leading)
//
//            }
////
////            VStack(alignment: .leading, spacing: 12) {
////                Text("Status")
////                    .font(.caption)
////                    .foregroundColor(.black)
////
////                Text("Completed")
////                    .frame( height: 30)
////                    .foregroundColor(.white)
////                    .background(
////                        ZStack{
////                            Capsule()
////                                .fill(.black)
////                        })
////
////                Divider()
////            }
////            .padding(.top,10)
////            .frame(maxWidth : .infinity, alignment: .leading)
//
//
//
//
//
//        }
//        .frame(maxHeight: .infinity, alignment : .top)
//        .padding()
//
//        NavigationView{
//            List{
//
//                Section {
//                    TextField("Go To Work", text: $taskTitle)
//                } header : {
//                    Text("Task Title")
//                }
//                Section {
//                    TextField("Nothing", text: $taskDescription)
//                } header : {
//                    Text("Task Description")
//                }
//                Section {
//                    DatePicker("", selection: $taskDate)
//                        .datePickerStyle(.graphical)
//                        .labelsHidden()
//                } header : {
//                    Text("Task Date")
//                }
//
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("Create New Task")
//            .navigationBarTitleDisplayMode(.inline)
//
//            // MARK: Disballing Dismiss on Swipe
//            //            .interactiveDismissDisabled()
//
//            // MARK: Action Buttons
//            .toolbar{
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Image(systemName: "plus")
//                    })
//
//                }
//
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//
//                        // CAN BE REEDIT
//
//                        if let task = taskModel.editTask{
//                            task.taskTitle = self.taskTitle
//                            task.taskDescription = self.taskDescription
//                        }else {
//                            let task = Task(context: context)
//                            task.taskTitle = self.taskTitle
//                            task.taskDescription = self.taskDescription
//                            task.taskDate = self.taskDate
//                        }
//
//
//
//                        //Saving
//                        try? context.save()
//                        dismiss()
//
//                    }, label: {
//                        Image(systemName: "plus")
//                    }).disabled(taskTitle == "" || taskDescription == "")
//
//                }
//
//            }
//            // Loading Task data if from Edit
//            .onAppear {
//                if let task = taskModel.editTask{
//                    taskTitle = task.taskTitle ?? ""
//                    taskDescription = task.taskDescription ?? ""
//                    taskDate = task.taskDate ?? Date()
//                }
//            }
//        }
//    }
//}
//
//struct CreateNewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewTaskView()
//            .environmentObject(TaskViewModel())
//    }
//}
