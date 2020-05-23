//
//  ViewController.swift
//  Split It!
//
//  Created by Dylan Kuster on 5/6/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class BillViewController: UIViewController
{
    
    @IBOutlet weak var enterTipButton: UIButton!
    @IBOutlet weak var peoplePicker: UIPickerView!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitItLabel: UILabel!
    
    var pickerViewData = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    var splitModel = SplitModel.shared
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        peoplePicker.delegate = self
        billTextField.delegate = self
        peoplePicker.dataSource = self
        enterTipButton.layer.cornerRadius = 25
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func endEditing()
    {
        billTextField.endEditing(true)
    }

    @IBAction func tipButtonPressed(_ sender: UIButton)
    {
        if billTextField.text != ""
        {
            if let billTotal = Float(billTextField.text!)
            {
                splitModel.billTotal = billTotal
                performSegue(withIdentifier: "goToTip", sender: self)
            }
            
            else
            {
                billTextField.text = ""
                billTextField.placeholder = "Enter amount"
            }
        }
        
        else
        {
            billTextField.placeholder = "Enter amount"
        }
    }
    
}

extension BillViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.endEditing(true)
    }
}

extension BillViewController : UIPickerViewDelegate, UIPickerViewDataSource
{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return String(pickerViewData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        splitItLabel.text = "Split It! between \(pickerViewData[row]) people"
        splitModel.peopleSplit = pickerViewData[row]
    }
    
}

