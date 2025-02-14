//
//  ContentView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 2/8/24.
//

import SwiftUI

struct SignInView: View {
    @State var password = UserDefaults.standard.string(forKey: "password") ?? ""
    
    var body: some View {
        VStack {
            
            Text("Kid Tech Balance")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
        
            Text("Create Passcode")
                .font(.title2)
            Form {
                SecureField("Passcode", text: $password)
                    .keyboardType(.numberPad)
            }
            .frame(width: 400, height: 100)
            .background(.white)
            .cornerRadius(10)
            
            Button(action: {
                UserDefaults.standard.setValue(password, forKey: "password")
            }, label: {
                Text("Submit")
                    .frame(width: 250, height: 50, alignment: .center)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Forgot Passcode?")
            })
                .frame(width: 150, height: 25, alignment: .center)
                .font(.subheadline)
                .foregroundColor(.white)
                .background(.gray)
                .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
