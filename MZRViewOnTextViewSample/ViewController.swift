//
//  ViewController.swift
//  MZRViewOnTextViewSample
//
//  Created by MORITA NAOKI on 2014/10/28.
//  Copyright (c) 2014年 molabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.textContainerInset = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0)
        let view = UIView(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(self.textView.frame), 100.0))
        view.backgroundColor = UIColor.greenColor()
        self.textView.addSubview(view)
        
        let button = UIButton.buttonWithType(.Custom) as UIButton
        button.frame = CGRectMake(10.0, 10.0, 100.0, 44.0)
        button.backgroundColor = UIColor.grayColor()
        button.setTitle("Push Me!", forState: .Normal)
        button.addTarget(self, action: "push:", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let notifications = [UIKeyboardWillShowNotification, UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification];
        for notification in notifications {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "fitKeyboard:", name: notification, object: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func fitKeyboard(notification: NSNotification) {
        let userInfo = notification.userInfo
        let duration = (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        let curve = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as NSNumber).unsignedIntegerValue
        let keyboardFrame = (userInfo?[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        let keyboardHeight = CGRectGetHeight(self.view.frame) - CGRectGetMinY(keyboardFrame)
        
        self.textViewBottomConstraint.constant = keyboardHeight
        let options = UIViewAnimationOptions(UInt(curve))
        UIView.animateWithDuration(duration, delay: 0.0, options: options, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func push(sender: UIButton) {
        println("button pushed!")
    }
}

