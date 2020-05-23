//
//  SplitViewController.swift
//  Split It!
//
//  Created by Dylan Kuster on 5/7/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class SplitViewController: UIViewController
{

    @IBOutlet weak var splitItAgainButton: UIButton!
    @IBOutlet weak var oweLabel: UILabel!
    
    let billTotal = SplitModel.shared.calculateTotalPer()
    
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
        splitItAgainButton.layer.cornerRadius = 25
        oweLabel.text = "You owe $\(billTotal) each."
    }
    
    @IBAction func splitAgainPressed(_ sender: Any)
    {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
