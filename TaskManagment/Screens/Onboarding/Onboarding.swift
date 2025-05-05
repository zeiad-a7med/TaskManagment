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
            pagingSubView()
            Spacer()
            CustomButton(
                text:"Let's Start",
                width: 100,
                onTap: {
                    NavigationManager.shared.push(.loginChannels)
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
