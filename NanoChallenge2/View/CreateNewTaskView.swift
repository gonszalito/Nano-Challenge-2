////
////  CreateNewTaskView.swift
////  NanoChallenge2
////
////  Created by Jonathan Andryana on 27/07/22.
////
//
//import SwiftUI
//
//struct CreateNewTaskView: View {
//    
//    @EnvironmentObject var taskModel : TaskViewModel
//    
//    // MARK: All Environment Values in one Variable
//    @Environment(\.self) var env
//    
//    var body: some View {
//        VStack(spacing:12){
//            Text("Edit Task")
//                .font(.title3.bold())
//                .frame(maxWidth : .infinity)
//                .overlay(alignment: .leading){
//                    Button {
//                        env.dismiss()
//                    } label: {
//                        Image(systemName: "arrow.left")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                    }
//                }
//            
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Task Title")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                // MARK: Sample Card Colors
//                
//                TextField("Task Title Here", task)
//                
//                HStack(spacing: 15){
//                    
//                }
//                .padding(.top,10)
//                
//            }
//            .frame(maxWidth : .infinity, alignment: .leading)
//            .padding(.top,30)
//            
//            Divider()
//                .padding(.vertical, 10)
//            
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Task color")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                
//                // MARK: Sample Card Colros
//                
//                HStack(spacing: 15){
//                    
//                }
//                .padding(.top,10)
//                
//            }
//            .frame(maxWidth : .infinity, alignment: .leading)
//            .padding(.top,30)
//            
//            Divider()
//                .padding(.vertical, 10)
//            
//            
//        }
//        .frame(maxHeight: .infinity, alignment : .top)
//        .padding()
//        
//        
//    }
//}
//
//struct CreateNewTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateNewTaskView()
//    }
//}
