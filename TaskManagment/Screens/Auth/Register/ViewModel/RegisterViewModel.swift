//
//  RegisterViewModel.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

import Foundation

class RegisterViewModel : ObservableObject{
    @Published var registerModel : RegisterModel = RegisterModel()
    @Published var isFormEnabled : Bool = false
    
    func signUp(){
        AuthService.signUp(registerData: self.registerModel) { response in
            print(response.message)
            NavigationManager.shared.push(.home)
        }
    }
    func updateUserInfo(registerData : RegisterModel){
        self.registerModel = registerData
        self.isFormEnabled = registerData.satisfy
    }
}
