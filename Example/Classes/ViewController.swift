//
//  ViewController.swift
//  SimpleReactive
//
//  Created by chronicqazxc on 05/03/2017.
//  Copyright (c) 2017 chronicqazxc. All rights reserved.
//

import UIKit
import SimpleReactive

class ViewController: UIViewController {
    
    @IBOutlet weak var value2TextField: UITextField! {
        didSet {
            value2TextField.delegate = self
        }
    }
    @IBOutlet weak var value2Display: UILabel!
    let singal = SimpleColdSignal("1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        singal.bindTo(label: value2Display)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        singal.next(newString ?? "")
        return true
    }
}
