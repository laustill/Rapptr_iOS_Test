//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

@available(iOS 13.0, *)
class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button Adjustments
        navigationBarAppearance()
        buttonAppearance()
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "Coding Tasks"
    }
    
    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        //disable the buttons so users are unable to cause multiple views to push onto one another
        chatButton.isUserInteractionEnabled = false
        loginButton.isUserInteractionEnabled = false
        animationButton.isUserInteractionEnabled = false
        chatButton.setTitle("Fetching Data", for: .normal)
        // Pulls the data before moving so the cells don't pop in while users stare at a blank screen
        let chatViewController = ChatViewController()
        let client = ChatClient()
        client.fetchChatData(completion: { (ReturnedMessages) -> Void in
            chatViewController.messages = ReturnedMessages
            DispatchQueue.main.async {
                self.chatButton.isUserInteractionEnabled = true
                self.chatButton.setTitle("Chat", for: .normal)
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        }, error: {  failureString in
            self.chatButton.isUserInteractionEnabled = true
            self.loginButton.isUserInteractionEnabled = true
            self.animationButton.isUserInteractionEnabled = true
            self.chatButton.setTitle("Chat", for: .normal)
        })
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
    
    //MARK: UI Adjustments
    func navigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "HeaderColor")
        let titleAdjustments = [NSAttributedString.Key
                            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = titleAdjustments
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    func buttonAppearance(){
        loginButton.layer.cornerRadius = 8
        chatButton.layer.cornerRadius = 8
        animationButton.layer.cornerRadius = 8
    }
}
