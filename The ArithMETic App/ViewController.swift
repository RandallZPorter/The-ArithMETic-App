//
//  ViewController.swift
//  The ArithMETic App
//
//  Created by Randall Zane Porter on 2/14/19.
//  Copyright © 2019 Randall Zane Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportsList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportsList[row]
    }
    let sportsList = ["Bicycling","Jumping rope","Running - slow","Running - fast", "Tennis", "Swimming"]
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var energyLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }


    @IBAction func calculate(_ sender: Any) {
        let activity:String = sportsList[pickerView.selectedRow(inComponent: 0)]
        let met:Double = ExerciseCoach.sportsDictionary[activity]!
        let weight:Double = Double(weightTF.text!)!
        let time:Double = Double(timeTF.text!)!
        energyLBL.text = String(ExerciseCoach.energyConsumed(met: met, weight: weight, time: time)) + " Cal"
        timeLBL.text = String(ExerciseCoach.timeToLose1Pound(met: met, weight: weight)) + " minutes"
    }
    @IBAction func clear(_ sender: Any) {
        weightTF.text = ""
        timeTF.text = ""
        energyLBL.text = "0 Cal"
        timeLBL.text = "0 minutes"
    }
}

struct ExerciseCoach {
    static let sportsDictionary:[String:Double] = ["Bicycling" : 8.0, "Jumping rope" : 12.3, "Running - slow" : 9.8, "Running - fast" : 23.0, "Tennis" : 8.0, "Swimming" : 5.8]
    static func energyConsumed(met:Double, weight:Double, time:Double) -> Double {
        return round(met * 3.5 * weight / 2.2 / 200.0 * time * 10)/10
    }
    static func timeToLose1Pound(met:Double, weight:Double) -> Double {
        return round( 3500 / (met * 3.5 * weight / 2.2 / 200.0) * 10)/10
    }
}
