//
//  RegisterViewModel.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

import Foundation

class LoginViewModel : ObservableObject{
    @Published var signInData : SignInModel = SignInModel()
    @Published var isFormEnabled : Bool = false
    
    func signIn(){
        AuthService.signIn(signInData: self.signInData) { response in
            print(response.message)
            NavigationManager.shared.push(.home)
        }
    }
    func updateUserInfo(signInData : SignInModel){
        self.signInData = signInData
        self.isFormEnabled = signInData.satisfy
    }
}
