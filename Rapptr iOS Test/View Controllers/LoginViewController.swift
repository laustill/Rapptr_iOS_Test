//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and parameters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        title = "Login"
        client = LoginClient()
        textFieldAdjustments(field: emailField)
        textFieldAdjustments(field: passwordField)
    }
    // MARK: - Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        client!.login(email: emailField.text!, password: passwordField.text!, completion: { returnedData, timeSince in
            DispatchQueue.main.async {
                if returnedData == "Error"{
                    self.sendAlert(timeSince: timeSince, success: false)
                }
                else{
                    self.sendAlert(timeSince: timeSince, success: true)
                }
            }
        }, error: { errorData in
            print("\(errorData!)")
        })
    }
    
    // MARK: -Alerts
    func sendAlert(timeSince: String, success: Bool){
        // Upon successful login, login page will dismiss
        if success == true{
            let alert = UIAlertController(title: "Login was successful!", message: "Time Taken: \(timeSince) milliseconds", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: dismissAfterAlert(alert:)))
            self.present(alert, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Login Failed!", message: "Time Taken: \(timeSince) milliseconds", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func dismissAfterAlert(alert: UIAlertAction!) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -TextFieldAdjustments
    func textFieldAdjustments(field: UITextField){
        let padding = UIView(frame: CGRect(x:0, y:0, width:24, height:field.frame.height))
        field.leftView = padding
        field.leftViewMode = UITextField.ViewMode.always
        field.layer.cornerRadius = 8
        field.clipsToBounds = true
        field.layer.opacity = 0.8
        if field == emailField {
        let placeholder = NSAttributedString(string: "Email",
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "LoginPlaceholder") ?? .red])
            field.attributedPlaceholder = placeholder
        }
        else {
            let placeholder = NSAttributedString(string: "Password",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "LoginPlaceholder") ?? .red])
            field.attributedPlaceholder = placeholder
        }
    }
}
