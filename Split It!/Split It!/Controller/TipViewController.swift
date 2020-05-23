//
//  TipViewController.swift
//  Split It!
//
//  Created by Dylan Kuster on 5/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var splitItButton: UIButton!
    @IBOutlet weak var customTipTextField: UITextField!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var fifteenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    
    var splitModel = SplitModel.shared
    var tipPercent : Float = 0.10
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        splitItButton.layer.cornerRadius = 25
        customTipTextField.delegate = self
        updateTipLabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func endEditing()
    {
        customTipTextField.endEditing(true)
    }
    
    @IBAction func fivePercentPressed(_ sender: UIButton)
    {
        sender.isSelected = true
        tenButton.isSelected = false
        fifteenButton.isSelected = false
        twentyButton.isSelected = false
        
        tipPercent = 0.05
        updateTipLabel()
    }
    
    @IBAction func tenPercentPressed(_ sender: UIButton)
    {
        sender.isSelected = true
        fiveButton.isSelected = false
        fifteenButton.isSelected = false
        twentyButton.isSelected = false
        
        tipPercent = 0.10
        updateTipLabel()
    }
    
    @IBAction func fifteenPercentPressed(_ sender: UIButton)
    {
        sender.isSelected = true
        tenButton.isSelected = false
        fiveButton.isSelected = false
        twentyButton.isSelected = false
        
        tipPercent = 0.15
        updateTipLabel()
    }
    
    @IBAction func twentyPercentPressed(_ sender: UIButton)
    {
        sender.isSelected = true
        tenButton.isSelected = false
        fifteenButton.isSelected = false
        fiveButton.isSelected = false
        
        tipPercent = 0.20
        updateTipLabel()
    }
    
    @IBAction func splitItPressed(_ sender: UIButton)
    {
        splitModel.tipPercent = tipPercent
        performSegue(withIdentifier: "showSplit", sender: self)
    }
    
    func deselectButtons()
    {
        fiveButton.isSelected = false
        tenButton.isSelected = false
        fifteenButton.isSelected = false
        twentyButton.isSelected = false
    }
    
    func updateTipLabel()
    {
        let tip = splitModel.billTotal * tipPercent
        let tipStr = String(format: "%.2f", tip)
        tipLabel.text = "Tip: $\(tipStr)"
    }

}

extension TipViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return customTipTextField.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if (textField.text != "")
        {
            let localTipPercent = Float(textField.text!) ?? 0.00
            let num : Float = 100.00
            tipPercent = localTipPercent / num
            deselectButtons()
            updateTipLabel()
        }
        
        textField.placeholder = "Or enter custom tip"
    }
}
