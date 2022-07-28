//
//  PopUpView.swift
//  NanoChallenge2
//
//  Created by Jonathan Andryana on 28/07/22.
//

import SwiftUI

struct PopUp: View {
    @State var date = Date()
    
    var body: some View {
        ZStack {
            DatePicker("label", selection: $date, displayedComponents: [.date])
                .datePickerStyle(CompactDatePickerStyle())
                .labelsHidden()
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
                .userInteractionDisabled()
        }
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }.allowsHitTesting(false)
    }
}

extension View {
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}
