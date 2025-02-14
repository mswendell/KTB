//
//  kidHistory.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI

struct kidHistory: View {
    @Binding var showMenu: Bool
    @Binding var showHistory: Bool
    
    var body: some View {
        
        Button("Back") {
            showHistory.toggle()
            showMenu.toggle()
        }
        .frame(width: 150, height: 40, alignment: .center)
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(8)
        
        VStack {
            Text("Kid Tech Balance")
                .font(.title)
            Text("Child Use History")
                .font(.title2)
            Text("Hello, World!")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

