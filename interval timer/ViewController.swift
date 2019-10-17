//
//  ViewController.swift
//  interval timer
//
//  Created by satsuki nakai on 2019/06/20.
//  Copyright © 2019 satsuki nakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var dateField2: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    var timer: Timer = Timer()
    var Label: UILabel!
    var count: Int = 0
    var data: Int = 0
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var myLabel : UILabel!
    var stopBtn:UIButton!
    var startBtn:UIButton!
    var pauseTime:Float = 0
    
    var isRepeat = false
    
    //時分秒のデータ
    let datalist = [[Int](0...23),[Int](0...59),[Int](0...59)]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        setPickerViewUnitLabel()
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        setPickerView2UnitLabel()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datalist[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return datalist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = NSTextAlignment.left
        pickerLabel.text = String(datalist[component][row])
        pickerLabel.backgroundColor = UIColor.red
        return pickerLabel
        
    }
    
    //ボタン押下時の呼び出しメソッド
    @IBAction func startButtonPressed() {
        timer.invalidate()
        
        if pauseTime == 0 {
            count = datalist[0][pickerView.selectedRow(inComponent: 0)] * 60 * 60
                +  datalist[1][pickerView.selectedRow(inComponent: 1)] * 60
                +  datalist[2][pickerView.selectedRow(inComponent: 2)]
            data = count
        } else {
            count = Int(pauseTime)
            
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
        
        self.view.addSubview(pickerView)
        
        //「分」をラベルに追加
        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
        mStr.frame = CGRect(x:pickerView.bounds.width/2 - mStr.bounds.width/2,
                            y:pickerView.bounds.height/2 - (mStr.bounds.height/2),
                            width:mStr.bounds.width, height:mStr.bounds.height)
        pickerView.addSubview(mStr)
        self.view.addSubview(pickerView)
        
        //「秒」をラベルに追加
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
        sStr.frame = CGRect(x:pickerView.bounds.width*8/10 - sStr.bounds.width/2,
                            y:pickerView.bounds.height/2 - (sStr.bounds.height/2),
                            width:sStr.bounds.width, height:sStr.bounds.height)
        pickerView.addSubview(sStr)
        self.view.addSubview(pickerView)
    }
    
    private func setPickerView2UnitLabel() {
        //「時間」のラベルを追加
        let hStr = UILabel()
        hStr.text = "時間"
        hStr.sizeToFit()
        hStr.frame = CGRect(x:pickerView2.bounds.width/4 - hStr.bounds.width/2,
                            y:pickerView2.bounds.height/2 - (hStr.bounds.height/2),
                            width:hStr.bounds.width, height:hStr.bounds.height)
        pickerView2.addSubview(hStr)
        
        self.view.addSubview(pickerView2)
        
        //「分」をラベルに追加
        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
        mStr.frame = CGRect(x:pickerView2.bounds.width/2 - mStr.bounds.width/2,
                            y:pickerView2.bounds.height/2 - (mStr.bounds.height/2),
                            width:mStr.bounds.width, height:mStr.bounds.height)
        pickerView2.addSubview(mStr)
        self.view.addSubview(pickerView2)
        
        //「秒」をラベルに追加
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
        sStr.frame = CGRect(x:pickerView2.bounds.width*8/10 - sStr.bounds.width/2,
                            y:pickerView2.bounds.height/2 - (sStr.bounds.height/2),
                            width:sStr.bounds.width, height:sStr.bounds.height)
        pickerView2.addSubview(sStr)
        self.view.addSubview(pickerView2)
    }
}