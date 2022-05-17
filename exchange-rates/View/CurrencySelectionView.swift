//
//  CurrencysSelectionView.swift
//  exchange rates
//
//  Created by APPLE on 06.04.2022.
//

import UIKit

final class CurrencySelectionView: UIView {

    //MARK: - Properties
    var tableView: UITableView!
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.register(CurrencySelectionCell.self, forCellReuseIdentifier: CurrencySelectionCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View hierarhy
    private func setupSubView() {
        self.addSubview(tableView)
    }
    
    //MARK: - Constaint
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
