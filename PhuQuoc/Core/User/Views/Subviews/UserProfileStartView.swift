//
//  UserProfileStartView.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 19/07/2023.
//

import SwiftUI

struct UserProfileStartView: View {
    
    @Binding var isPresented: Bool
    @State var displayName = ""
    @State var phoneNumber = ""
    @State var birthDate = Date()
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top){
                    ZStack{
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(Color("PrimaryYellow").opacity(0.5))
                            .offset(x: 4, y: 5)
                        Image("Wavy_Check")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .frame(width: 30.0,height: 30.0)
                    }
                    Text("More posibilities with your data!")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(.bottom)
                        .offset(y: 2)
                }
                Text("Display name")
                    .font(.system(size: 16, weight: .bold, design: .default))
                TextField("", text: $displayName)
                    .frame(height: 36)
                    .padding([.leading, .trailing], 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                Text("Phone number")
                    .font(.system(size: 16, weight: .bold, design: .default))
                TextField("", text: $phoneNumber)
                    .frame(height: 36)
                    .padding([.leading, .trailing], 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                HStack{
                    VStack(alignment: .leading){
                        Text("Birthdate")
                            .font(.system(size: 16, weight: .bold, design: .default))
                        DatePicker("", selection: $birthDate, displayedComponents: .date)
                            .labelsHidden()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .keyboardType(.default)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Gender")
                            .font(.system(size: 16, weight: .bold, design: .default))
                        Picker(selection: .constant(1)) {
                            Text("Female").tag(1)
                            Text("Male").tag(2)
                            Text("Other").tag(3)
                        }
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 20)
                Text("We Care About Your Privacy.")
                    .font(.system(size: 14, weight: .bold, design: .default))
                Text("To improve your app experience, we may collect and analyze certain personal data, such as your usage patterns and preferences. Rest assured, all data is anonymized and securely stored. We respect your privacy and will never share your personal information with third parties without your consent. By using this app, you agree to our Privacy Policy. If you have any questions, please reach out to us at privacy@exampleapp.com.")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .padding(.bottom, 10)
                HStack {
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Skip")
                    })
                    .frame(width: 80, height: 36)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }, label: {
                        Text("Save")
                    })
                    .frame(width: 80, height: 36)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
    }
}


struct UserProfileStartView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileStartView(isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
