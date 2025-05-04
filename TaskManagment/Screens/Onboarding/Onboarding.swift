//
//  Onboarding.swift
//  TaskManagment
//
//  Created by Zeiad on 04/05/2025.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack{
            Image("onboarding")
                .resizable()
                .scaledToFit()
            Text("Task Managment & To-Do List")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Spacer().frame(height: 20)
            Text("This productive tool is designed to help you better manage your task project-wise conveniently!")
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            CustomButton(
                text:"Let's Start",
                width: 100,
                onTap: {
                    print("Tapped")
                },
                isButtonEnabled: .constant(true)
            )
        }.background{
            BubblesBackground()
        }
        .padding()

    }
}

#Preview {
    Onboarding()
}
