//
//  RegisterResponse.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

struct SignInModel {
    var email: String?
    var password: String?

    func copyWith(

        email: String? = nil,
        password: String? = nil,

    ) -> SignInModel {
        return SignInModel(
            email: email ?? self.email,
            password: password ?? self.password,

        )
    }
    var satisfy: Bool {
        if email == nil || email!.isEmpty
            || password == nil || password!.isEmpty
        {
            return false
        }
        return true
    }
}
