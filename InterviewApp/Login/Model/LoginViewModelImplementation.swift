//
//  LoginViewModelImplementation.swift
//  InterviewApp
//
//  Created by Abd Sani Abd Jalal on 28/04/2023.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModelImplementation: LoginViewModel {
    let emailText = BehaviorRelay<String>(value: "")
    let passwordText = BehaviorRelay<String>(value: "")
    let loginButtonTapped = PublishRelay<Void>()
    let service = AuthService()
    var loginValidate = BehaviorRelay<Bool>(value: false)

    var loginEnabled: Observable<Bool> {
        Observable.combineLatest(emailText.asObservable(), passwordText.asObservable())
            .map { email, password in
                !email.isEmpty && !password.isEmpty
            }
    }
    
    func login() {
        
        self.service.login(email: emailText.value, password: passwordText.value) { isSuccess, error in
            self.loginValidate.accept(isSuccess)
        }
    }
}
