//
//  FireBaseResponse.swift
//  TaskManagment
//
//  Created by Zeiad on 11/05/2025.
//

import Foundation

struct FireBaseUser{
    var uid : String
    var email : String?
    var displayName : String?
    var photoURL : URL?
    var providerID : String
    var isEmailVerified : Bool
    var refreshToken : String?
    var phoneNumber : String?
}
