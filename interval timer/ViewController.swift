//
//  ViewController.swift
//  interval timer
//
//  Created by satsuki nakai on 2019/06/20.
//  Copyright © 2019 satsuki nakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
    var pickerView: UIPickerView = UIPickerView()
    var pickerView2: UIPickerView = UIPickerView()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Label2: UILabel!
    
    var datePicker: UIDatePicker = UIDatePicker()
    var timer: Timer = Timer()
    
    var count: Int = 0
    var count2: Int = 0
    var data: Int = 0
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var hours2: Int = 0
    var minutes2: Int = 0
    var seconds2: Int = 0
    var myLabel : UILabel!
    var stopBtn:UIButton!
    var startBtn:UIButton!
    var pauseTime:Float = 0
    var timehour : Int = 0
    var timeminute : Int = 0
    var timesecond : Int = 0
    var timehour2: Int = 0
    var timeminute2: Int = 0
    var timesecond2: Int = 0
    var isRepeat = false
    
    
    
    //時分秒のデータ
    let datalist = [[Int](0...23),[Int](0...59),[Int](0...59)]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        setPickerViewUnitLabel()
        
        //        pickerView2.delegate = self
        //        pickerView2.dataSource = self
        //        setPickerView2UnitLabel()
        //
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.textField.inputView = pickerView
        self.textField.inputAccessoryView = toolbar
        
        let toolbar2 = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.done2))
        let cancelItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancel2))
        toolbar2.setItems([cancelItem2, doneItem2], animated: true)
        
        self.textField2.inputView = pickerView
        self.textField2.inputAccessoryView = toolbar2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datalist[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return datalist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width * 1/4
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = NSTextAlignment.left
        pickerLabel.text = String(datalist[component][row])
        //pickerLabel.backgroundColor = UIColor.red
        return pickerLabel
        
    }
    
    //ボタン押下時の呼び出しメソッド
    @IBAction func startButtonPressed() {
        timer.invalidate()
        
        if pauseTime == 0 {
            count = timehour * 60 * 60
                +  timeminute * 60
                +  timesecond
            data = count
        } else {
            count = Int(pauseTime)
            
        }
        
        if pauseTime == 0 {
            count2 = timehour2 * 60 * 60
                +  timeminute2 * 60
                +  timesecond2
            data = count2
        } else {
            count2 = Int(pauseTime)
            
        }
        
        //1秒周期でcountDownメソッドを呼び出すタイマーを開始する。
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(countDown),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    let scWid: CGFloat = UIScreen.main.bounds.width     //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    
    @IBAction func stop() {
        pauseTime = Float(count)
        timer.invalidate()
    }
    
    @IBAction func reset() {
        Label.text = String("0")
        Label2.text = String("0")
        pauseTime = 0
        data = 0
        
    }
    
    @IBAction func repeatSwitchtoggled(_ sender: Any) {
        isRepeat.toggle()
    }
    
    //タイマーから呼び出されるメソッド
    @objc func countDown(){
        //カウントを減らす。
        if count > 0 {
            count -= 1
        } else {
            count -= 0
        }
        
        hours = count/3600
        minutes = (count - hours*3600)/60
        seconds = count - hours*3600 - minutes*60
        print("hoge")
        Label.text = "残り\(hours)時間\(minutes)分\(seconds)秒です。"
        
        //カウントダウン状況をラベルに表示
        if count == 0 {
            Label.text = "カウントダウン終了"
            
            
            if isRepeat {
                count = data
                
            } else {
                timer.invalidate()
            }
            return //returnでこのメソッドの処理を終了
        }
        
        if count2 > 0 {
                   count2 -= 1
               } else {
                   count2 -= 0
               }
               
               hours2 = count2/3600
               minutes2 = (count2 - hours2*3600)/60
               seconds2 = count2 - hours2*3600 - minutes2*60
               Label2.text = "残り\(hours2)時間\(minutes2)分\(seconds2)秒です。"
               
        if count2 == 0 {
            Label2.text = "カウントダウン終了"
            
            
            if isRepeat {
                count2 = data
                
            } else {
                timer.invalidate()
            }
            return //returnでこのメソッドの処理を終了
        }

    }
    
    private func setPickerViewUnitLabel() {
        //「時間」のラベルを追加
        let hStr = UILabel()
        hStr.text = "時間"
        hStr.sizeToFit()
        hStr.frame = CGRect(x:pickerView.bounds.width/4 - hStr.bounds.width/2,
                            y:pickerView.bounds.height/2 - (hStr.bounds.height/2),
                            width:hStr.bounds.width, height:hStr.bounds.height)
        pickerView.addSubview(hStr)
        
        //self.view.addSubview(pickerView)
        
        //「分」をラベルに追加
        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
        mStr.frame = CGRect(x:pickerView.bounds.width/1.9 - mStr.bounds.width/2,
                            y:pickerView.bounds.height/2 - (mStr.bounds.height/2),
                            width:mStr.bounds.width, height:mStr.bounds.height)
        pickerView.addSubview(mStr)
        //self.view.addSubview(pickerView)
        
        //「秒」をラベルに追加
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
        sStr.frame = CGRect(x:pickerView.bounds.width*17/20 - sStr.bounds.width/2,
                            y:pickerView.bounds.height/2 - (sStr.bounds.height/2),
                            width:sStr.bounds.width, height:sStr.bounds.height)
        pickerView.addSubview(sStr)
        //self.view.addSubview(pickerView)
    }
    
    @objc func cancel() {
        self.textField.text = ""
        self.textField.endEditing(true)
    }
    
    @objc func cancel2() {
        self.textField2.text = ""
        self.textField2.endEditing(true)
    }
    
    @objc func done() {
        self.textField.endEditing(true)
        self.textField.text = String(datalist[0][pickerView.selectedRow(inComponent: 0)]) + "時間"+String(datalist[0][pickerView.selectedRow(inComponent: 1)]) + "分"+String(datalist[0][pickerView.selectedRow(inComponent: 2)]) + "秒"
        
        timehour = datalist[0][pickerView.selectedRow(inComponent: 0)]
        timeminute = datalist[0][pickerView.selectedRow(inComponent: 1)]
        timesecond = datalist[0][pickerView.selectedRow(inComponent: 2)]
        
    }
    
    @objc func done2() {
        self.textField2.endEditing(true)
        self.textField2.text = String(datalist[0][pickerView.selectedRow(inComponent: 0)]) + "時間"+String(datalist[0][pickerView.selectedRow(inComponent: 1)]) + "分"+String(datalist[0][pickerView.selectedRow(inComponent: 2)]) + "秒"
        
        timehour2 = datalist[0][pickerView.selectedRow(inComponent: 0)]
        timeminute2 = datalist[0][pickerView.selectedRow(inComponent: 1)]
        timesecond2 = datalist[0][pickerView.selectedRow(inComponent: 2)]
              
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
}
