//
//  CurrencySelectionController.swift
//  exchange rates
//
//  Created by APPLE on 26.04.2022.
//

import UIKit

class CurrencySelectionController: UIViewController {
    
    let flagiArray = ["USD", "EUR", "GBP", "CNY", "CHF", "AUD", "CAD"]
    
    var viewCurrency: CurrencySelectionView {
        return self.view as! CurrencySelectionView}
    
    var onFinish: ((Valute)->())?
    
    //MARK:- Lifecycle
    override func loadView() {
        super.loadView()
        self.view = CurrencySelectionView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationBar()
        viewCurrency.tableView.delegate = self
        viewCurrency.tableView.dataSource = self
        
    }
    
    //MARK:- Setup navigationBar
    private func setupNavigationBar() {
        title = "Добавить валюту"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
//MARK:- Extension
extension CurrencySelectionController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        flagiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionCell.identifier, for: indexPath) as! CurrencySelectionCell
        
        let charCode = flagiArray[indexPath.row]
        
        guard let nameValute =  Data.shared.valuteArray?.valute[charCode] else {return cell}
        
        let isSelected = Data.shared.valuteArray?.valute[charCode]?.isSelected
        
        cell.configureCell(model: nameValute)
        
        switch isSelected {
        
        case true:
            cell.accessoryType = .checkmark
        case false:
            cell.accessoryType = .none
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! CurrencySelectionCell
        
        let charCode = flagiArray[indexPath.row]
        
        guard var data = Data.shared.valuteArray?.valute[charCode] else {return}
        
        switch data.isSelected {
        case true:
            Data.shared.valuteArray?.valute[charCode]?.isSelected = false
            data.isSelected = false
            cell.accessoryType = .none
        case false:
            Data.shared.valuteArray?.valute[charCode]?.isSelected = true
            data.isSelected = true
            cell.accessoryType = .checkmark
        }
        onFinish?(data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
