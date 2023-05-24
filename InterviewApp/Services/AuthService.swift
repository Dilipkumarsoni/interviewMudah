//
//  AuthService.swift
//  InterviewApp
//
//  Created by Abd Sani Abd Jalal on 28/04/2023.
//

import Foundation
import RxSwift
import RxCocoa

enum AuthError: Error {
    case wrongCredential
    case serverLimit
}

class AuthService: AuthServiceType {
    typealias CompletionHandler = (Bool, AuthError?) -> Void
    
    func login(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        if email == "1@mudah.my" && password == "1234" {
            completionHandler(true, nil)
        } else {
            completionHandler(false, .wrongCredential)
        }
    }
}
