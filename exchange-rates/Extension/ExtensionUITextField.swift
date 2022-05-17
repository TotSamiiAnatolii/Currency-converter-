//
//  ExtensionUITextField.swift
//  exchange rates
//
//  Created by APPLE on 04.04.2022.
//

import Foundation
import UIKit

extension UITextField {
    internal func addBottomBorder(height: CGFloat = 0.8, color: UIColor = #colorLiteral(red: 0.6585034839, green: 0.6585034839, blue: 0.6585034839, alpha: 1)) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        borderView.layer.shadowOpacity = 0.5
        borderView.layer.shadowRadius = 1.0
        addSubview(borderView)
        NSLayoutConstraint.activate([
                borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
