//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func messageFormatting(){
        body.layer.borderWidth = 1
        body.layer.borderColor = UIColor(named: "ViewBackground")?.cgColor
        body.layer.cornerRadius = 8
        body.clipsToBounds = true
    }
    func imageFormatting(){
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
    }
    // MARK: - Public
    func setCellData(message: Message) {
        messageFormatting()
        imageFormatting()
        header.text = message.username
        body.text = message.message
        guard let url = message.avatarURL else {
            return
        }
        getImageFromURL(link: url)
    }
    
    func getImageFromURL(link: URL) {
        if let imageData = try? Data(contentsOf: link) {
            if let loadedImage = UIImage(data: imageData) {
                avatarImage.image = loadedImage
            }
        }
    }
}
