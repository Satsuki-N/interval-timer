//
//  ViewController.swift
//  interval timer
//
//  Created by satsuki nakai on 2019/06/20.
//  Copyright © 2019 satsuki nakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
    
    let datalist = [[Int](0...23),[Int](0...59),[Int](0...59)] //時分秒のデータ
    
    @IBOutlet weak var mainTimertextField: UITextField!
    @IBOutlet weak var intervalTimertextField: UITextField!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var intervalNumberLabel: UILabel!
    
    var timer: Timer = Timer()
    
    var inputIntervalNumber: Int = 0 //入力したインターバル回数
    var countIntervalNumber: Int = 0 //実際にインターバルした回数
    
    var inputMainTimerHour: Int = 0 //入力したメインタイマー　（時間）
    var inputMainTimerMinute: Int = 0 //入力したメインタイマー　（分）
    var inputMainTimerSecond: Int = 0 //入力したメインタイマー　（秒）
    var mainCount: Int = 0 //メインタイマーの合計秒数
    var remainingMainTimeHour: Int = 0 //メインタイマー残り時間　（時間）
    var remainingMainTimeMinute: Int = 0 //メインタイマー残り時間　（分）
    var remainingMainTimeSecond: Int = 0 //メインタイマー残り時間　（秒）
    
    var inputIntervalTimerHour: Int = 0 //入力したインターバルタイマー　（時間）
    var inputIntervalTimerMinute: Int = 0 //入力したインターバルタイマー　（分）
    var inputIntervalTimerSecond: Int = 0 //入力したインターバルタイマー　（秒）
    var intervalCount: Int = 0 //インターバルタイマーの合計秒数
    var remainingIntervalTimeHour: Int = 0 //インターバルタイマーの残り時間　　（時間）
    var remainingIntervalTimeMinute: Int = 0 //インターバルタイマーの残り時間　（分）
    var remainingIntervalTimeSecond: Int = 0 //インターバルタイマーの残り時間　（秒）
    
    var mainTimerWork : Bool = false //メインタイマーが動いているかどうか
    var intervalTimerWork : Bool = false //インターバルタイマーが動いているかどうか
    var timerStop  : Bool = false //タイマーが止まっているかどうか
    
    var timePickerView:UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        setPickerViewUnitLabel()
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        
        self.mainTimertextField.inputView = timePickerView
        self.mainTimertextField.inputAccessoryView = toolbar
        
        
        let toolbar2 = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.done2))
        let cancelItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewController.cancel2))
        toolbar2.setItems([cancelItem2, doneItem2], animated: true)
        
        
        self.intervalTimertextField.inputView = timePickerView
        self.intervalTimertextField.inputAccessoryView = toolbar2
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
        return pickerLabel
        
    }
    
    //pickerView内のラベルの位置
     private func setPickerViewUnitLabel() {
         //「時間」のラベルを追加
         let hStr = UILabel()
         hStr.text = "時間"
         hStr.sizeToFit()
         hStr.frame = CGRect(x:timePickerView.bounds.width/4 - hStr.bounds.width/2,
                             y:timePickerView.bounds.height/2 - (hStr.bounds.height/2),
                             width:hStr.bounds.width, height:hStr.bounds.height)
         timePickerView.addSubview(hStr)
         
         //self.view.addSubview(pickerView)
         
         //「分」をラベルに追加
         let mStr = UILabel()
         mStr.text = "分"
         mStr.sizeToFit()
         mStr.frame = CGRect(x:timePickerView.bounds.width/1.9 - mStr.bounds.width/2,
                             y:timePickerView.bounds.height/2 - (mStr.bounds.height/2),
                             width:mStr.bounds.width, height:mStr.bounds.height)
         timePickerView.addSubview(mStr)
         //self.view.addSubview(pickerView)
         
         //「秒」をラベルに追加
         let sStr = UILabel()
         sStr.text = "秒"
         sStr.sizeToFit()
         sStr.frame = CGRect(x:timePickerView.bounds.width*17/20 - sStr.bounds.width/2,
                             y:timePickerView.bounds.height/2 - (sStr.bounds.height/2),
                             width:sStr.bounds.width, height:sStr.bounds.height)
         timePickerView.addSubview(sStr)
         //self.view.addSubview(pickerView)
     }
    
      @objc func cancel() {
            self.mainTimertextField.text = ""
            self.mainTimertextField.endEditing(true)
        }
        
        @objc func cancel2() {
            self.intervalTimertextField.text = ""
            self.intervalTimertextField.endEditing(true)
        }
        
        @objc func done() {
            self.mainTimertextField.endEditing(true)
            self.mainTimertextField.text = String(datalist[0][timePickerView.selectedRow(inComponent: 0)]) + "時間"+String(datalist[0][timePickerView.selectedRow(inComponent: 1)]) + "分"+String(datalist[0][timePickerView.selectedRow(inComponent: 2)]) + "秒"
            
            inputMainTimerHour = datalist[0][timePickerView.selectedRow(inComponent: 0)]
            inputMainTimerMinute = datalist[0][timePickerView.selectedRow(inComponent: 1)]
            inputMainTimerSecond = datalist[0][timePickerView.selectedRow(inComponent: 2)]
    
        }
        
        @objc func done2() {
            self.intervalTimertextField.endEditing(true)
            self.intervalTimertextField.text = String(datalist[0][timePickerView.selectedRow(inComponent: 0)]) + "時間"+String(datalist[0][timePickerView.selectedRow(inComponent: 1)]) + "分"+String(datalist[0][timePickerView.selectedRow(inComponent: 2)]) + "秒"
            
            inputIntervalTimerHour = datalist[0][timePickerView.selectedRow(inComponent: 0)]
            inputIntervalTimerMinute = datalist[0][timePickerView.selectedRow(inComponent: 1)]
            inputIntervalTimerSecond = datalist[0][timePickerView.selectedRow(inComponent: 2)]
            
        }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
           return CGRect(x: x, y: y, width: width, height: height)
       }
    
    @IBAction func stepperDidTap(stepper: UIStepper){
        intervalNumberLabel.text = String(stepper.value)
        inputIntervalNumber = Int(stepper.value)
    }
    
    
    //ボタン押下時の呼び出しメソッド
    @IBAction func start() {
        
        if mainTimerWork == false && intervalTimerWork == false {
            mainCount = inputMainTimerHour * 60 * 60
            + inputMainTimerMinute * 60
            + inputMainTimerSecond
        
            intervalCount = inputIntervalTimerHour * 60 * 60
            +  inputIntervalTimerMinute * 60
            +  inputIntervalTimerSecond
            countIntervalNumber = 0
            //1秒周期でcountDownメソッドを呼び出すタイマーを開始する。
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(countDown),
                                         userInfo: nil,
                                         repeats: true)
        }else{
        timerStop = false
        }
    }
    
    @IBAction func stop() {
        timerStop = true
    }
    
    @IBAction func reset() {
        mainLabel.text = "リセットしました"
        mainTimerWork = false
        intervalTimerWork = false
        timer.invalidate()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.mainLabel.text = "0"
        }
    }
    
    //タイマーから呼び出されるメソッド
    @objc func countDown(){
        switch (mainTimerWork,intervalTimerWork){
        case (false,false):
            mainTimerWork = true
            mainLabel.text = "カウントを開始します"
        case (true,false):
            if timerStop != true{
                mainCountDown()
            }else if timerStop == true{
                break
            }
        case (false,true):
            if timerStop != true{
                intervalCountDown()
            }else if timerStop == true{
                break
            }
        default:
            break
            }
        }
        
    func mainCountDown() {
        if mainCount > 0{
                remainingMainTimeHour = mainCount/3600
                remainingMainTimeMinute = (mainCount - remainingMainTimeHour*3600)/60
                remainingMainTimeSecond = mainCount - remainingMainTimeHour*3600 - remainingMainTimeHour*60
            let mainTimeHourtext = String(format: "%02d", remainingMainTimeHour)
            let mainTimeMinuteText = String(format: "%02d", remainingMainTimeMinute)
            let mainTimeSecondtext = String(format: "%02d", remainingMainTimeSecond)
            
            mainLabel.text = "\(mainTimeHourtext):\(mainTimeMinuteText)’\(mainTimeSecondtext)"
                mainCount -= 1
    }else if mainCount == 0{
                if countIntervalNumber < inputIntervalNumber{
                    mainLabel.text = "インターバルスタート"
                    mainTimerWork = false
                    intervalTimerWork = true
               
                    intervalCount = inputIntervalTimerHour * 60 * 60
                    +  inputIntervalTimerMinute * 60
                    +  inputIntervalTimerSecond
                }else if countIntervalNumber == inputIntervalNumber{
                    mainLabel.text = "終了です。"
                    mainTimerWork = false
                    intervalTimerWork = false
                    timer.invalidate()
                }
    }
    }
    
    func intervalCountDown() {
          mainLabel.text = "インターバルに入ります。"
          if intervalCount > 0{
              remainingIntervalTimeHour = intervalCount/3600
              remainingIntervalTimeMinute = (intervalCount - remainingIntervalTimeHour*3600)/60
              remainingIntervalTimeSecond = intervalCount - remainingIntervalTimeHour*3600 - remainingIntervalTimeHour*60
            let intervalTimeHourtext = String(format: "%02d", remainingIntervalTimeHour)
            let intervalTimeMinutetext = String(format: "%02d", remainingIntervalTimeMinute)
            let intervalTimeSecondtext = String(format: "%02d", remainingIntervalTimeSecond)
            mainLabel.text = "\(intervalTimeHourtext):\(intervalTimeMinutetext)’\(intervalTimeSecondtext)"
              intervalCount -= 1
          }else if intervalCount == 0{
              mainLabel.text = "インターバル終了"
              mainTimerWork = true
              intervalTimerWork = false
              mainCount = inputMainTimerHour * 60 * 60
              +  inputMainTimerMinute * 60
              +  inputMainTimerSecond
              countIntervalNumber += 1//インターバル回数をカウントする。
          }
      }


}
