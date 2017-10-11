//
//  LogInVC.swift
//  Fetch
//
//  Created by Pablo Garces on 10/11/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class LogInVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var usernameField: AnimatedTextField!
    @IBOutlet weak var passField: AnimatedTextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollInnerView: UIView!
    
    var firstTimeOpen = false
    var kbHeight = CGFloat()
    var signInBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passField.delegate = self
        usernameField.delegate = self
        
        scrollView.delegate = self
        scrollView.alwaysBounceHorizontal = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: scrollView.frame.size.height)
        
        signInBtn.backgroundColor = UIColor(red: 87/255, green: 171/255, blue: 222/255, alpha: 1)
        signInBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.setTitleColor(.white, for: .normal)
        signInBtn.addTarget(self, action: #selector(signInBtnPressed), for: .touchUpInside)
        signInBtn.frame = CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 60)
        view.addSubview(signInBtn)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if firstTimeOpen == false {
            if let userInfo = notification.userInfo {
                if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    kbHeight = keyboardSize.height
                    
                }
            }
            
            firstTimeOpen = true
        }
        
        self.animateScrollView(up: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.animateScrollView(up: false)
    }
    
    func animateScrollView(up: Bool) {
        
        if up == true {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbHeight + 10, right: 0)
        } else {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func signInBtnPressed() {
        
        Auth.auth().signIn(withEmail: usernameField.text!.lowercased() , password: passField.text!) { (user, error) in
            if error != nil {
                print("failure")
                return
            }
            print("success")
            //example of how to get url image sdimage : self.mainImg.sd_setImage(with:user?.photoURL!)
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

