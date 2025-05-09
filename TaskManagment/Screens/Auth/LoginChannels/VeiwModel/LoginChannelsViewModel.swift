//
//  LoginChannelsViewModel.swift
//  TaskManagment
//
//  Created by Zeiad on 09/05/2025.
//

import Foundation
import UIKit
import GoogleSignIn
class LoginChannelsViewModel : ObservableObject{
    
    func singInWithGoogle(){
        AuthService.signInWithGoogle { result in
            print("result : \(result)")
            NavigationManager.shared.push(.home)
        }
    }
    
    func signInWithFacebook(){
        AuthService.signInWithFacebook { result in
            
        }
    }
    
    
}
