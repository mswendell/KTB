//
//  authView.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 7/10/24.
//

import SwiftUI

struct authView: View {
    @State var password1: String = ""
    @State var showError = false
    @State var showConf = false
    @State var password: String = (UserDefaults.standard.string(forKey: "password") ?? "")
    @Binding var authorize: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Kid Tech Balance")
                        .font(.largeTitle)
                        .padding(.bottom, 30)
                    
                    Text("Password Authentication")
                        .font(.title3)
                }
                Spacer()
            }
            Spacer()
            
            Text("Enter Password")
            SecureField("Password", text: $password1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width:200)
                .padding(.bottom, 30)
            if showError {
                Text("Incorrect Password")
                    .foregroundColor(.red)
            }
            if showConf {
                Text("Override Approved")
                    .foregroundColor(.green)
            }
            Button("Submit Password") {
                if password1 == password {
                    //show green confirmation
                    authorize = true
                    UserDefaults.standard.setValue(authorize, forKey: "auth")
                    showError = false
                    showConf = true
                }
                else  {
                    //show error
                    showError = true
                }
            }
            .frame(width: 300, height: 80, alignment: .center)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, 30)
            .font(.title2)
            Spacer()
        }
    }
}

#Preview {
    authView(authorize: .constant(false))
}
