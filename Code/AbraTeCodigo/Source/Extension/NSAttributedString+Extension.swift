//
//  NSAttributedString+Extension.swift
//  AbraTeCodigo
//
//  Created by Ailton Vieira Pinto Filho on 25/10/20.
//

import UIKit

extension NSAttributedString {
    static func string(_ text: String, suffix image: UIImage) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: text)
        fullString.append(.init(string: " "))
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        
        return fullString
    }
}

extension String {
    func withVerified() -> NSAttributedString {
        NSAttributedString.string(self, suffix: UIImage(systemName: "checkmark.seal.fill")!.withTintColor(#colorLiteral(red: 0.137254902, green: 0.1450980392, blue: 0.2, alpha: 1)))
    }
}
