//
//  RegisterResponse.swift
//  TaskManagment
//
//  Created by Zeiad on 06/05/2025.
//

struct RegisterModel {
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var confirmPassword: String?

    func copyWith(
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        password: String? = nil,
        confirmPassword: String? = nil
    ) -> RegisterModel {
        return RegisterModel(
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            email: email ?? self.email,
            password: password ?? self.password,
            confirmPassword: confirmPassword ?? self.confirmPassword
        )
    }
    var satisfy: Bool {
        if firstName == nil || firstName!.isEmpty
            || lastName == nil || lastName!.isEmpty
            || email == nil || email!.isEmpty
            || password == nil || password!.isEmpty
            || password != confirmPassword
        {
            return false
        }
        return true
    }
}
