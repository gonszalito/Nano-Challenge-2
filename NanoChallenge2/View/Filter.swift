//
//  DynamicFilterView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 27/07/22.
//

import SwiftUI
import CoreData

struct DynamicFilterView<Content: View,T>: View where T : NSManagedObject{
    
    // MARK: Core Data Request
    
    @FetchRequest var request: FetchedResults<T>
    let content : (T)->Content
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(dateToFilter: Date, @ViewBuilder content :  @escaping  (T)-> Content){
        
        // MARK: Predicate to Filter
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: dateToFilter)
        let tomorrow = calendar.date(byAdding: .day,value: 1, to: today)!
        
        // Filter Key
        let filterKey = "taskDate"
        
        // This will fetch task between today and tommorow (24 hrs)
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) =< %@", argumentArray: [today,tomorrow])
        
        // Initializing Request with NSPRedicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty{
                Text("No tasks Available")
                    .font(.title.bold())
                    .fontWeight(.light)
                    .offset(y: 100)
            }else {
                
                ForEach(request,id: \.objectID) { object in
                    self.content(object)
                    
                }
                
            }
        }
    }
}



