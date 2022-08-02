//
//  CalendarWeek.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 02/08/22.
//

import SwiftUI

struct CalendarWeek: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CalendarWeek_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWeek()
    }
}

struct CustomController: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let dayViewController = CustomCalendarExampleController()
        return dayViewController
    }
}
