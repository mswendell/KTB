//
//  MainMenuView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 2/11/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack{
            Text("Main Menu")
                .font(.title)
            HStack{
                Spacer()
                VStack{
                    Text("Parent Name")
                    Text("Children")
                    Text("1. Children")
                    Text("2. Children")
                    Text("3. Children")
                    Text("4. Children")
                }
                Spacer()
                
                VStack {
                    Button("Start") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .frame(width: 200, height: 100)
                Button("History") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .frame(width: 100, height: 75)
                }
                Spacer()
            }
            Button("Settings") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
        }
            
    }
}

#Preview {
    MainMenuView()
}
