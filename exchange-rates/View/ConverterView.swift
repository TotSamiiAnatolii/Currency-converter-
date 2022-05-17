//
//  ConverterView.swift
//  exchange rates
//
//  Created by APPLE on 08.03.2022.
//

import UIKit

final class ConverterView: UIView {
    
    //MARK:- Properties

    var onAction: (()->())?
    var tableView: UITableView!
    
    private let labelFIXRUB: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Российский рубль"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let textFieldRUB: UITextField = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.text = " RUB"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .left
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.leftViewMode = .always
        textField.text = "1"
        textField.leftView = label
        textField.addBottomBorder()
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let imageFixRUB: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 30
        button.image = UIImage(named: "Russia")
        button.clipsToBounds = true
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
        return button
    }()
  
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifire)
    }
 
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View hierarhy
    private func setupSubView(){
        self.addSubview(textFieldRUB)
        self.addSubview(labelFIXRUB)
        self.addSubview(imageFixRUB)
        self.addSubview(tableView)
    }
    
    //MARK:- Constraint
    private func setupConstraint() {
        //Label flag russia
        NSLayoutConstraint.activate([
            imageFixRUB.widthAnchor.constraint(equalToConstant: 60),
            imageFixRUB.heightAnchor.constraint(equalToConstant: 60),
            imageFixRUB.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            imageFixRUB.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(self.frame.height / 4))
        ])
        
        //TextField RUB
        NSLayoutConstraint.activate([
            textFieldRUB.widthAnchor.constraint(equalToConstant: 300),
            textFieldRUB.heightAnchor.constraint(equalToConstant: 40),
            textFieldRUB.leadingAnchor.constraint(equalTo: imageFixRUB.trailingAnchor, constant: 10),
            textFieldRUB.bottomAnchor.constraint(equalTo: imageFixRUB.bottomAnchor, constant: -25)
        ])
        
        //Label Russia rubl
        NSLayoutConstraint.activate([
            labelFIXRUB.widthAnchor.constraint(equalToConstant: self.frame.width),
            labelFIXRUB.topAnchor.constraint(equalTo: textFieldRUB.bottomAnchor, constant: 4),
            labelFIXRUB.leadingAnchor.constraint(equalTo: textFieldRUB.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: imageFixRUB.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        onAction?()
    }
}
