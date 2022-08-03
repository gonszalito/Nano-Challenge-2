//
//  WeekViiew.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 03/08/22.
//

import SwiftUI


struct WeekView: View {
    
    var cards = [
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        
    ]
    
    @State var initDate: Date!
    @State var startDate : Date!
    var initialContentOffset = CGPoint.zero
    var currentPage: Int!
    var loading = false
    var isFirst = true
    var daysToShow : Int = 0
    var daysToShowOnScreen: Int = 0
    var calendarDate: Date!
    
    let days : [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
       
        
        VStack {
            HStack(spacing: 0){
                ForEach(days,id: \.self){
                    day in
                    Text(day)
                        .font(.system(size:14))
                        .fontWeight(.semibold)
                        .frame(maxWidth:.infinity)
                    
                }
            }
            ScrollView{
                            HStack(spacing: 0){
                    
                LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(cards) { card in
                            WeekCardView(title: card.title)
                                .frame(height: 100)
                        }
                    }
                    .padding()
                 
                    
                    
//                    LazyVGrid(columns: columns, spacing: 15){
//                        ForEach(0...7) { card in
//
//                                    Text("\(card)")
//                                        .font(.system(size:14))
//                                        .fontWeight(.semibold)
//                                        .frame(maxWidth:.infinity)
//                                }
//                            }
//                            .padding()
                    
                    
                }
                
            
        }
        }
        .padding(.top, 20)
        .frame(maxHeight:.infinity, alignment: .top)
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}

struct CardViewCustom: View {
    let title: String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12).foregroundColor(.red)
            Text(title)
                .font(.title2)
        }
        
    }
}
