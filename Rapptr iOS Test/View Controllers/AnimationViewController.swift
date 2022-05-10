//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import AVFoundation
@available(iOS 13.0, *)
class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    private var endAudioPlayer: AVAudioPlayer? = nil
    private var thxAudio = NSURL(fileURLWithPath: Bundle.main.path(forResource: "THX", ofType: "wav")!)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        title = "Animation"
        
    }
    
    // MARK: - Outlets
    @IBOutlet weak var fadeButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    var fadedIn = false
    @IBAction func didPressFade(_ sender: Any) {
        if !fadedIn {
            loadAudio()
            endAudioPlayer?.volume = 0.5
            endAudioPlayer?.numberOfLoops = 0
            endAudioPlayer?.play()
            let toImage = UIImage(named:"ic_logo.png")
            UIView.transition(with: logoView,
                              duration: 7.0,
                              options: .transitionCrossDissolve,
                              animations: { self.logoView.image = toImage },
                              completion: nil)
            fadedIn = true
            fadeButton.setTitle("Fade Out", for: .normal)
        }
        else {
            let toImage = UIImage(named:"")
            UIView.transition(with: logoView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.logoView.image = toImage },
                              completion: nil)
            fadedIn = false
            fadeButton.setTitle("Fade In", for: .normal)
        }
    }
    
    //MARK: -UI and Audio setup
    func UISetup(){
        fadeButton.titleLabel?.text = "Fade In"
        let dragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didDrag(_:)))
        logoView.addGestureRecognizer(dragRecognizer)
        logoView.frame = CGRect(x:self.view.frame.midX/6,y:self.view.frame.height/3,width:logoView.frame.width,height:logoView.frame.height)
    }
    
    @objc func didDrag(_ sender: UIPanGestureRecognizer){
        logoView.center = sender.location(in: self.view)
    }
    
    func loadAudio() {
        let path = Bundle.main.path(forResource: "THX", ofType: "wav")
        let audioURL = URL(fileURLWithPath: path!)
        do {
            endAudioPlayer = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("unable to load audio file")
        }
    }
}
