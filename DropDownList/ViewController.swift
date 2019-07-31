//
//  ViewController.swift
//  DropDownList
//
//  Created by Всеволод Андрющенко on 27/07/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputLabel: UITextField!
    @IBOutlet weak var variantTableView: UITableView!
    
    
    private var allData: [String] = ["слон", "сова", "собака", "серп", "сокол", "сосиска", "автомобиль", "автомойка"]
    private var actualData: [String] = []
    
    var startPointTable = CGPoint()
    var sizeTable = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gest = UILongPressGestureRecognizer()
        gest.addTarget(self, action: #selector(viewTapPress))
        view.addGestureRecognizer(gest)
        
        inputLabel.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startPointTable = variantTableView.frame.origin
        sizeTable = variantTableView.frame.size
    }
    
    
    //Marc: нахождение совпадений с введенными данными
    @objc func textFieldDidChange(_ textField: UITextField) {
        var buffDate = ActualDate()
        
        if let inputText = inputLabel.text{
            DispatchQueue.concurrentPerform(iterations: allData.count) { (index) in
                if allData[index].contains(inputText){
                    buffDate.append(allData[index])
                }
            }
        }
        
        actualData = buffDate.valueDateArray
        variantTableView.reloadData()
    }
    
    @objc func viewTapPress(){
        self.view.frame.origin.y = 0
        view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startInputAnimation()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = -200
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = 0
        inputLabel.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endInputAnimation()
    }

    
    private func startInputAnimation(){
        UIView.animate(withDuration: 0.3) {
            self.variantTableView.frame = CGRect(origin: self.startPointTable, size: CGSize(width: self.sizeTable.width + 50, height: self.sizeTable.height))
            self.inputLabel.frame = CGRect(origin: self.inputLabel.frame.origin, size: CGSize(width: self.inputLabel.frame.size.width + 50, height: self.inputLabel.frame.size.height))
        }
    }
    
    private func endInputAnimation(){
        UIView.animate(withDuration: 0.3) {
            let sizeClose = CGSize(width: 0, height: 0)
            self.variantTableView.frame = CGRect(origin: self.startPointTable, size: sizeClose )
            self.inputLabel.frame = CGRect(origin: self.inputLabel.frame.origin, size: CGSize(width: self.inputLabel.frame.size.width - 50, height: self.inputLabel.frame.size.height))
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputText = actualData[indexPath.row]
        inputLabel.text = inputText
        inputLabel.resignFirstResponder()
        self.view.frame.origin.y = 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = actualData[indexPath.row]
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 29.0
    }
}
