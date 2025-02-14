//
//  parentSettings.swift
//  Kids Tech Balance
//
//  Created by Michael Wendell on 3/1/24.
//

import SwiftUI

struct parentSettings: View {
    @State var password1: String = ""
    @State var password2: String = ""
    @State var password3: String = ""
    @State var showError = false
    @State var showError2 = false
    @State var showConf = false
    @State var password: String = (UserDefaults.standard.string(forKey: "password") ?? "")
    @Binding var showMenu: Bool
    @Binding var showPassword: Bool
    
    var body: some View {
        VStack {
            Button("Back") {
                showPassword.toggle()
                showMenu.toggle()
            }
            .frame(width: 150, height: 40, alignment: .center)
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .offset(x:-500)
            HStack {
                Spacer()
                VStack {
                    Text("Kid Tech Balance")
                        .font(.largeTitle)
                        .padding(.bottom, 30)
                    
                    Text("Password Settings")
                        .font(.title3)
                }
                Spacer()
            }
            Spacer()
            
            Text("Enter Previous Password")
            SecureField("Old Password", text: $password3)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width:200)
                .padding(.bottom, 30)
            Text("Enter New Password")
            SecureField("New Password", text: $password1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width:200)
                .padding(.bottom, 30)
            Text("Confirm New Password")
            SecureField("Confirm Password", text: $password2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width:190)
                
            Spacer()

            if showError {
                Text("New Passwords Do not Match")
                    .foregroundColor(.red)
            }
            if showError2 {
                Text("Old Password Incorrect")
                    .foregroundColor(.red)
            }
            if showConf {
                Text("Password Changed Success")
                    .foregroundColor(.green)
            } 
            Button("Create New Password") {
                if password3 == password {
                    showError2 = false
                    if password1 == password2 {
                        //show green confirmation
                        password = password1
                        UserDefaults.standard.setValue(password, forKey: "password")
                        showError = false
                        showConf = true
                    }
                    else  {
                        //show error
                        showError = true
                        showConf = false
                    }
                }
                else {
                    showError2 = true
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
    mainMenu(showMenu: false, showTask: false, showSet: false, showUse: false, showReview: false, showPassword: true)
        .environmentObject(DataModel())

}
