//
//  EditUserView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 09/07/2023.
//

import SwiftUI

struct UserEditView: View {
    
    @StateObject private var vm = UserViewModel() // UserViewModel init
    
    @State var displayName: String // Display name
    @State var phoneNumber: String // Phone number
    @State var birthdate = Date() // Birth Date
    
    /// Modifiers
    @State private var isDatePickerShown = false // Picker show: true/false
    
    var body: some View {
        
        VStack(alignment:.leading){
            List {
                Section(header: Text("Profile")) {
                    HStack {
                        Text("Display Name")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Spacer()
                        TextField("Enter your display name", text: $displayName)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: displayName){ newValue in
                                displayName = displayName
                            }
                    }
                    HStack {
                        Text("Phone")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Spacer()
                        TextField("Enter your Phone number", text: $phoneNumber)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: phoneNumber){ newValue in
                                phoneNumber = phoneNumber
                            }
                    }
                    HStack{
                        Text("Birthdate")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Spacer()
                        DatePicker("", selection: $birthdate, displayedComponents: .date)
                            .labelsHidden()
                            .keyboardType(.default)
                        
                    }
                    HStack{
                        Text("Gender")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                        Spacer()
                        Picker(selection: .constant(2)) {
                            Text("Female").tag(1)
                            Text("Male").tag(2)
                            Text("Other").tag(3)
                        }
                        
                    }
                    
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Enable Notifications", isOn: .constant(false))
                    Toggle("Dark Mode", isOn: .constant(true))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button(action: {
                // Update user information
            }) {
                Text("Save")
            })
            
        }
    }
    
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        let testUser = User(name: "", birth: Date(), coupons: [], favorite: [], gender: "Male", photo: "", phone: "", visits: [])
        UserEditView(
            displayName: testUser.name,
            phoneNumber: testUser.phone ?? "Empty",
            birthdate: testUser.birth ?? Date()
        )
    }
    
    static func getSampleDate() -> Date? {
        let calendar = Calendar.current
        let components = DateComponents(year: 2022, month: 6, day: 1)
        return calendar.date(from: components)
    }
}
