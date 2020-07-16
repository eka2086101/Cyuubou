//
//  LoginViewController.swift
//  GsTodo
//
//  Created by 鈴江元尚 on 2020/06/13.
//  Copyright © 2020 yamamototatsuya. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //メールアドレス入力欄
    @IBOutlet weak var emailTextField: UITextField!
    
    //パスワード入力欄
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //新規登録ボタン処理
    @IBAction func tapSignUpButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if email.isEmpty && password.isEmpty{
                   self.showAlert(title: "エラー", message: "メールアドレスとパスワードを入力して下さい")
               } else if email.isEmpty {
                   self.showAlert(title: "エラー", message: "メールアドレスを入力して下さい")
               } else if password.isEmpty {
                   self.showAlert(title: "エラー", message: "パスワードを入力して下さい")
               } else {
            //emailとメールアドレスのいずれも入力されていれば、新規登録処理
                   self.emailSignUp(email: email, password: password)
               }
    }
    
    //ログインボタン処理
    @IBAction func tapLoginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if email.isEmpty && password.isEmpty{
            self.showAlert(title: "エラー", message: "メールアドレスとパスワードを入力して下さい")
        } else if email.isEmpty {
            self.showAlert(title: "エラー", message: "メールアドレスを入力して下さい")
        } else if password.isEmpty {
            self.showAlert(title: "エラー", message: "パスワードを入力して下さい")
        } else {
            //emailとメールアドレスのいずれも入力されていれば、ログイン処理
            self.emailLogIn(email: email, password: password)
        }
    }
    
    //利用規約処理
    @IBAction func tapTermsButton(_ sender: Any) {
        //WebKit Viewを持つTermsViewControllerをインスタンス化
//        let termsVC = TreekViewController()
//        //表示
//        self.present(termsVC, animated: true, completion: nil)
    }
    
    //新規登録の処理
    func emailSignUp (email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            //NSError?型にキャストしたerrorをアンラップ
            if let error = error as NSError? {
                //エラー時の処理
                self.signUpErrAlert(error)
            } else {
                //成功時の処理
                self.presentTaskList()
            }
        }
    }
    
    //ログインの処理
    func emailLogIn (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            //NSError?型にキャストしたerrorをアンラップ
            if let error = error as NSError?{
                //エラー時の処理
                self.signInErrAlert(error)
            } else {
                //成功時の処理
                self.presentTaskList()
                
//                //WebKit Viewを持つTermsViewControllerをインスタンス化
//                let termsVC = TreekViewController()
//                //表示
//                self.present(termsVC, animated: true, completion: nil)
            }
        }
    }
    
    //新規登録の際のエラー処理
    func signUpErrAlert(_ error: NSError){
        //引数errorの持つcodeを使って、EnumであるAuthErrorCodeを呼び出し
        if let errCode = AuthErrorCode(rawValue: error.code) {
            //表示するメッセージを格納する変数を宣言
            var message = ""
            //errCodeの値によってメッセージを出しわけ
            switch errCode {
            //AuthErrorCode.invalidEmailといった書き方を省略
            case .invalidEmail:      message =  "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse: message = "既に登録されているメールアドレスです"
            case .weakPassword:      message = "パスワードは６文字以上で入力してください"
            default:                 message = "エラー: \(error.localizedDescription)"
            }
            //アラートを表示
            self.showAlert(title: "登録できません", message: message)
        }
    }
    
    //ログインの際のエラー処理
    func signInErrAlert(_ error: NSError){
        //引数errorの持つcodeを使って、EnumであるAuthErrorCodeを呼び出し
        if let errCode = AuthErrorCode(rawValue: error.code) {
            //表示するメッセージを格納する変数を宣言
            var message = ""
            //errCodeの値によってメッセージを出しわけ
            switch errCode {
            //AuthErrorCode.userNotFoundといった書き方を省略
            case .userNotFound:  message = "アカウントが見つかりませんでした"
            case .wrongPassword: message = "パスワードを確認してください"
            case .userDisabled:  message = "アカウントが無効になっています"
            case .invalidEmail:  message = "Eメールが無効な形式です"
            default:             message = "エラー: \(error.localizedDescription)"
            }
            //アラートを表示
            self.showAlert(title: "ログインできません", message: message)
        }
    }
    
    //成功時の画面遷移処理
    func presentTaskList() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //アラートを表示する関数
    func showAlert(title: String, message: String?) {
           //UIAlertControllerを、関数の引数であるtitleとmessageを使ってインスタンス化
           let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
           //UIAlertActionを追加
           alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
           //表示
           self.present(alertVC, animated: true, completion: nil)
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//extension UIViewController {
//    func showAlert(title: String, message: String?) {
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }
//}
