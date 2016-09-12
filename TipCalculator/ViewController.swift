//
//  ViewController.swift
//  TipCalculator
//
//  Created by Michail on 9/12/16.
//  Copyright © 2016 mishaparadising. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var sumCountField: UITextField!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    // MARK: Properties
    var sum = Sum(current: 0, tipPercentage: 15)
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTipSlider()
        addToolbarToNumberPad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initTipSlider() {
        tipSlider.maximumValue = 100
        tipSlider.minimumValue = 0
        
        tipSlider.setValue(Float(15), animated: false)
        
        tipSlider.userInteractionEnabled = false
    }
    
    // MARK: Actions
    @IBAction func tipSliderAction(sender: UISlider) {
        tipTitleLabel.text = "Tip(\(Int(sender.value))%):"
        sum.tipPercentage = Double(sender.value);
        
        updateTipValueLabel()
        updateTotalValueLabel()
    }
    
    
    // MARK: Helpers
    func addToolbarToNumberPad() {
        let numberKeypadToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        
        numberKeypadToolbar.barStyle = UIBarStyle.Default
        
        numberKeypadToolbar.items = [
            UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItemStyle.Plain,
                target: self,
                action: #selector(numberPadDoneButtonTapped))
        ]
        
        numberKeypadToolbar.sizeToFit()
        
        sumCountField.inputAccessoryView = numberKeypadToolbar
    }
    
    func numberPadDoneButtonTapped() {
        let sumCountFieldText = sumCountField.text!;
        let parsedValue : Double = Double(sumCountFieldText)!
        
        let roundedSumCountFieldValue = sumCountFieldText.isEmpty ? 0 : parsedValue
        
        sumCountField.text = "$" + roundedSumCountFieldValue.formatWithDefaultValue()
        sumCountField.resignFirstResponder();
        
        sum.current = roundedSumCountFieldValue;
        
        tipSlider.userInteractionEnabled = true
        
        updateTipValueLabel()
        updateTotalValueLabel()
    }
    
    func updateTipValueLabel() {
        tipValueLabel.text = "$\(sum.tipValue.formatWithDefaultValue())"
    }
    
    func updateTotalValueLabel() {
        totalValueLabel.text = "$\(sum.totalSum.formatWithDefaultValue())"
    }
    
    struct Sum {
        var current : Double = 0
        
        var tipPercentage : Double = 0
        var tipValue : Double {
            get {
                return current * (tipPercentage / 100)
            }
        }
        
        var totalSum : Double {
            get {
                return current + tipValue
            }
        }
    }
}



