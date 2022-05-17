//
//  CurrencySelectionCell.swift
//  exchange rates
//
//  Created by APPLE on 06.04.2022.
//

import UIKit

final class CurrencyCell: UITableViewCell {
   
    //MARK: - Properties
    static let identifire = "CurrencyCell"
    
    private let labelNameValute: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 2
        return label
    }()
    
   private let labelCharCode: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    public let textFieldValute: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.addBottomBorder()
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()

    private let imageValute: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 30
        imageView.image = UIImage(named: "Russia")
        imageView.clipsToBounds = true
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 3
        imageView.layer.masksToBounds = false
        return imageView
    }()
  
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAddSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Public
    public func configureCell(model: Valute ) {
        labelNameValute.text = model.name
        imageValute.image = UIImage(named: model.charCode)
        textFieldValute.text = String(model.value)
        labelCharCode.text = model.charCode
        textFieldValute.leftView = labelCharCode
    }
 
    //MARK:- View hierarhies
    private func setupAddSubViews() {
        contentView.addSubview(imageValute)
        contentView.addSubview(labelNameValute)
        contentView.addSubview(textFieldValute)
    }
    
    //MARK:- Constraints
    private func setupConstraints() {
        //Button сurrency selection
        NSLayoutConstraint.activate([
            imageValute.widthAnchor.constraint(equalToConstant: 60),
            imageValute.heightAnchor.constraint(equalToConstant: 60),
            imageValute.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            imageValute.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        //TextField selection currency
        NSLayoutConstraint.activate([
            textFieldValute.widthAnchor.constraint(equalToConstant: 270),
            textFieldValute.heightAnchor.constraint(equalToConstant: 40),
            textFieldValute.leadingAnchor.constraint(equalTo: imageValute.trailingAnchor, constant: 10),
            textFieldValute.bottomAnchor.constraint(equalTo: imageValute.bottomAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            labelNameValute.widthAnchor.constraint(equalToConstant: 280),
            labelNameValute.topAnchor.constraint(equalTo: textFieldValute.bottomAnchor, constant: 4),
            labelNameValute.leadingAnchor.constraint(equalTo: textFieldValute.leadingAnchor)
        ])
    }
}
