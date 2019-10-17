//
//  pickerViewController.swift
//  interval timer
//
//  Created by satsuki nakai on 2019/09/12.
//  Copyright © 2019 satsuki nakai. All rights reserved.
//

import UIKit

class pickerViewController: UIViewController {
    
    var time: Timer?
    
    var datePicker: UIDatePicker = UIDatePicker()
//    var dataPicker2: UIDataPicker2 = UIDataPicker()
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var dataField2: UITextField!
    var ud = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.locale = Locale(identifier: "ja_JP")
        datePicker.datePickerMode = UIDatePicker.Mode.time
        datePicker.timeZone = NSTimeZone.local
        //datePicker.locale = Locale.current
        dateField.inputView = datePicker
        
//        datePicker2.locale = Locale(identifier: "ja_JP")
//        datePicker2.datePickerMode = UIDatePicker.Mode.date
//        datePicker2.timeZone = NSTimeZone.local
//        datePicker2.locale = Locale.current
//        dateField2.inputView = datePicker2

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
        
        dataField2.inputView = datePicker
        
//        dataField2.inputView = datePicker2
        dataField2.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        dateField.endEditing(true)
        dataField2.endEditing(true)
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ja_JP")
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .medium
        dateformatter.dateFormat = "yy時間MM分dd秒"
        dateField.text = "\(dateformatter.string(from: datePicker.date))"
        dataField2.text = "\(dateformatter.string(from: datePicker.date))"
    }
    
}
