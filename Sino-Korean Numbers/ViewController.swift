//
//  ViewController.swift
//  Sino-Korean Numbers
//
//  Created by Akbal Juarez on 6/16/15.
//  Copyright (c) 2015 akbalini. All rights reserved.
//

import Cocoa

infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

class ViewController: NSViewController , NSTextViewDelegate{

    @IBOutlet var decimalNumber: NSTextField!
    @IBOutlet weak var koreanStringLabel: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    func textDidChange(notification: NSNotification) {
         NSLog("editando")
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        NSLog("editando")
        var formatter = NSNumberFormatter()
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        //var stringValue = decimalNumber.stringValue
        //NSLog("NSNumber1 : \(stringValue)")
        //decimalNumber.stringValue = stringValue.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//        var intVal3 = decimalNumber.stringValue
//        NSLog("NSNumber2 : \(intVal3)")
//        var intValueFromString = stringValue.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//        NSLog("Int en string: \(decimalNumber.stringValue)")
//        NSLog("Int : \(intValueFromString)")
//        var intValue = formatter.numberFromString(intValueFromString)?.integerValue
//        NSLog("NSNumber : \(intValue)")
        
        if var intVal = formatter.numberFromString(decimalNumber.stringValue.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))?.integerValue {
            if(intVal<10000000000000000){
            koreanStringLabel.stringValue=numberDecimaltoStringKorean(intVal)
            decimalNumber.stringValue = "\(intVal)"
            decimalNumber.currentEditor()?.moveToEndOfLine(nil)
            }else{
                koreanStringLabel.stringValue="Numero muy grande"
            }
        }
    }
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    let koreanDigitNames = [
        0:"영", 1:"일", 2:"이", 3:"삼", 4:"사", 5:"오", 6:"육", 7:"칠", 8:"팔", 9:"구"]
    
    
    let koreanPoweString = [0:"", 1:"십", 2:"백",3:"천", 4:"만", 5:"십",6:"백", 7:"천", 8:"억", 9:"십",10:"백",11:"천",12:"조",13:"십",14:"백",15:"천"]
    
    func koreanString(number: Int, base:Int, maxPower: Int, originalNumber:Int) -> String {
        if number%10 != 0{
            var digitToString = koreanDigitNames[number%10]!
            return  number%10 != 1  ? digitToString + koreanPoweString[base]!: base != 0 && base != 4 && base != 8 && base != 12 ? koreanPoweString[base]!:base == 4 && (originalNumber%(10^^8) < (10^^5)) ? koreanPoweString[base]! : base == 8 && (originalNumber%(10^^12) < (10^^9)) ? koreanPoweString[base]!: base == 12 && (originalNumber%(10^^16) < (10^^13)) ? koreanPoweString[base]! : base != 0 ? digitToString + koreanPoweString[base]!:digitToString
        }else {
            return base == 4 && (originalNumber%(10^^8) > (10^^4)) ? "만": base == 8 && (originalNumber%(10^^12) > (10^^8)) ? "억" : base == 12 && (originalNumber%(10^^16) > (10^^12)) ? "조" :""
        }
        
    }
    func numberDecimaltoStringKorean(decimalNumber:Int) -> String{
        var output = ""
        var number = decimalNumber
        var power: Int = 0
        var lenght:Int = Int(log10(Float(decimalNumber)))
        if number/10<1 && number == 0 {
            output = koreanDigitNames[number%10]!
        }else{
            while number > 0 {
                var numberString:String = ""
                output = koreanString(number, base: power, maxPower: lenght, originalNumber: decimalNumber) + output
                //output = koreanString(number, power, lenght,decimalNumber) + output
                power++
                number /= 10
            }
        }
        return output
    }
    

}

