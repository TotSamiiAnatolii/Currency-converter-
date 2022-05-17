//
//  СonverterViewController.swift
//  exchange rates
//
//  Created by APPLE on 08.03.2022.
//

import UIKit

final class ConverterViewController: UIViewController {
    
    //MARK:- Properties
  
    private var converterView: ConverterView {
        return self.view as! ConverterView}
    
    private var favoriteArray: [Valute] = []
    
    private let converterServices = RatesAPI()
        
    //MARK:- LifeCycle
    override func loadView() {
        super.loadView()
        self.view = ConverterView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        converterView.tableView.delegate = self
        converterView.tableView.dataSource = self
        
        converterView.onAction = {
            self.textFieldDidChange()
        }
        
        converterServices.getRates { [weak self] currency, _   in
            guard let self = self else {return}
            Data.shared.valuteArray = currency
            Data.shared.valuteArray?.valute["USD"]?.isSelected = true
            self.favoriteArray.append((Data.shared.valuteArray?.valute["USD"])!)
            DispatchQueue.main.async {
                self.converterView.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        converterView.tableView.isEditing = false
        setupNavigationBar()
    }
    
    //MARK:- Action
   private func setupNavigationBar() {
        title = "Конвертер валют"
        navigationController?.navigationBar.prefersLargeTitles = true
        let editButton = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editButtonAction))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.setRightBarButtonItems([addButton, editButton], animated: true)
    }
    
    @objc func addAction() {
        let currencySelection = CurrencySelectionController()
        
        navigationController?.pushViewController(currencySelection, animated: true)
        
        currencySelection.onFinish = {[weak self] currency in
            guard let self = self else {return}
            
            if currency.isSelected == true {
                
                self.favoriteArray.append(currency)
                
            }else {
                for (index, value) in self.favoriteArray.enumerated() {
                    if value.charCode == currency.charCode {
                        self.favoriteArray.remove(at: index)
                    }
                }
            }
            self.converterView.tableView.reloadData()
        }
        converterView.tableView.isEditing = false
    }
    
    @objc func editButtonAction(sender: UIBarButtonItem) {
        
        converterView.tableView.isEditing = !converterView.tableView.isEditing
        
        sender.title = (converterView.tableView.isEditing) ? "Готово" : "Редактировать"
    }
    
    private func textFieldDidChange() {
        converterView.tableView.reloadData()
    }
    
    private func calculateExchangeRate(model: Valute, number: String) -> String {
        
        let value = model.value
        
        guard let number = Double(number) else {return ""}
        
        let rezult = number / value
        
        return String(format: "%.2f", rezult)
    }
    
    private func deleteCurrency(index: Int) {
        
        let charCode = favoriteArray[index].charCode
        
        favoriteArray.remove(at: index)
        
        Data.shared.valuteArray?.valute[charCode]?.isSelected = false
    }
}
//MARK: Extension
extension ConverterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifire, for: indexPath) as! CurrencyCell
        
        let valute = favoriteArray[indexPath.row]
        
        cell.configureCell(model: valute)
        
        cell.textFieldValute.text = calculateExchangeRate(model: valute, number: converterView.textFieldRUB.text ?? "" )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .delete:
            deleteCurrency(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

