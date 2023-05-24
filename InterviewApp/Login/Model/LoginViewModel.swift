//
//  LoginViewModel.swift
//  InterviewApp
//
//  Created by Abd Sani Abd Jalal on 28/04/2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewModel {
    var emailText: BehaviorRelay<String> { get }
    var passwordText: BehaviorRelay<String> { get }
    var loginButtonTapped: PublishRelay<Void> { get }
    var loginEnabled: Observable<Bool> { get }
    var loginValidate: BehaviorRelay<Bool> { get }

    func login()
}

