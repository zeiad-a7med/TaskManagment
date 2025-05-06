//
//  AuthService.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

protocol AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    )
}

class AuthService: AuthServiceProtocol {
    static func signUp(
        registerData: RegisterModel,
        completion: @escaping (RegisterResponse) -> Void
    ) {
        completion(
            RegisterResponse(message: "success register", success: true)
        )
    }

}
