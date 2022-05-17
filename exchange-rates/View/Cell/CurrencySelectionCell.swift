//
//  CurrencySelectionCell.swift
//  exchange rates
//
//  Created by APPLE on 08.04.2022.
//

import UIKit

final class CurrencySelectionCell: UITableViewCell {
    
    //MARK:- Properties
    static let identifier = "CurrencySelectionCell"
    
    private let countryFlagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "Russia")
        imageView.clipsToBounds = true
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 3
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    private let nameCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAddSubViews()
        setupConstraint()
        selectedBackgroundView?.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public
    func configureCell(model: Valute) {
        nameCurrencyLabel.text = "\(model.charCode) \(model.name)"
        countryFlagImage.image = UIImage(named: model.charCode)
    }
    
    //MARK:- Hierarhy view
    private func setupAddSubViews() {
        contentView.addSubview(countryFlagImage)
        contentView.addSubview(nameCurrencyLabel)
    }
    
    //MARK:- Constraint
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            countryFlagImage.widthAnchor.constraint(equalToConstant: 40),
            countryFlagImage.heightAnchor.constraint(equalToConstant: 40),
            countryFlagImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryFlagImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameCurrencyLabel.widthAnchor.constraint(equalToConstant: self.frame.width),
            nameCurrencyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCurrencyLabel.leadingAnchor.constraint(equalTo: countryFlagImage.trailingAnchor, constant: 10)
        ])
    }
}
