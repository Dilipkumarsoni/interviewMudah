//
//  LoginViewController.swift
//  InterviewApp
//
//  Created by Abd Sani Abd Jalal on 28/04/2023.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel: LoginViewModel
    
    init(model: LoginViewModel = LoginViewModelImplementation()) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.isHidden = true

        self.bindViewModel()
    }
    
    private func bindViewModel() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
        

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.login()
            })
            .disposed(by: disposeBag)
        
        viewModel.loginEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.loginValidate
            .subscribe(onNext: { [weak self] isSucess in
                guard let self = self else { return }
                if isSucess {
                    self.navigateToItemList()
                } else {
                    self.errorLabel.isHidden = (self.viewModel.emailText.value.isEmpty && self.viewModel.passwordText.value.isEmpty) ? true : false
                }
            })
            .disposed(by: disposeBag)
    }
    
    func navigateToItemList() {
        self.navigationController?.pushViewController(ItemListViewController(), animated: true)
    }
}
