//
//  SignUpVC.swift
//  Fetch
//
//  Created by Pablo Garces on 10/8/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var signUpInnerView: UIView!
    @IBOutlet weak var nameField: AnimatedTextField!
    @IBOutlet weak var emailField: AnimatedTextField!
    @IBOutlet weak var phoneField: AnimatedTextField!
    @IBOutlet weak var usernameField: AnimatedTextField!
    @IBOutlet weak var cityField: AnimatedTextField!
    @IBOutlet weak var passField: AnimatedTextField!
    @IBOutlet weak var conPassField: AnimatedTextField!
    
    @IBOutlet weak var signUpProgBack: UIView!
    @IBOutlet weak var signUpProgBar: UIProgressView!
    @IBOutlet weak var scrollBottomCon: NSLayoutConstraint!
    
    @IBOutlet weak var youBtn: UIButton!
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var dogsBtn: UIButton!
    
    var nextBtn = UIButton()
    var kbHeight: CGFloat!
    var firstTimeOpen = false
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpScrollView.delegate = self
        
        signUpProgBack.layer.cornerRadius = 5
        signUpProgBack.layer.masksToBounds = true
        
        signUpProgBar.progressViewStyle = .bar
        //signUpProgBar.backgroundColor = lightThemeGreen
        signUpProgBar.transform = signUpProgBar.transform.scaledBy(x: 1, y: 10)
        signUpProgBar.progressTintColor = UIColor(red: 87/255, green: 171/255, blue: 222/255, alpha: 1)
        
        nextBtn.backgroundColor = UIColor(red: 87/255, green: 171/255, blue: 222/255, alpha: 1)
        nextBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        nextBtn.setTitle("NEXT", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        nextBtn.frame = CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 60)
        view.addSubview(nextBtn)
        
        nameField.delegate = self
        emailField.delegate = self
        phoneField.delegate = self
        usernameField.delegate = self
        cityField.delegate = self
        passField.delegate = self
        conPassField.delegate = self
        

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
        
        signUpScrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: signUpScrollView.frame.size.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //pageNumber = Int(signUpScrollView.contentOffset.x / view.frame.size.width)
    }
    
    @objc func checkInputs() -> Bool {
        
        //TODO: Check for valid inpus in all fields for the main profile
        
        return true
    }
    
    @objc func checkDogInputs() -> Bool {
        
        //TODO: Check for valid inpus in all fields for the dog profile
        
        return true
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
            self.signUpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbHeight + 10, right: 0)
        } else {
            self.signUpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            
        })
    }
    
    @objc func nextBtnPressed() {
        
        print("Before: ", pageNumber)
        
        if pageNumber == 0 {
            
            if checkInputs() {
                
                print("Good Profile Info!")
                signUpProgBar.animate(duration: 0.5, value: Float(0.5))
                signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
                
            } else {
                print("Incorrect Info!")
            }
            
        } else if pageNumber == 1 {
            
            signUpProgBar.animate(duration: 0.5, value: Float(0.82))
            signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width * 2, y: 0), animated: true)
        } else {
            
            // Segue Here if Dog Info is Good
        }
        
        print("After: ", pageNumber)
    }
    
    @IBAction func youBtnPressed(_ sender: Any) {
        
        signUpProgBar.animate(duration: 0.5, value: Float(0.15))
        signUpScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        pageNumber = 0
    }
    
    @IBAction func photoBtnPressed(_ sender: Any) {
        
        if checkInputs() {
            signUpProgBar.animate(duration: 0.5, value: Float(0.5))
            signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
            pageNumber = 1
        } else {
            print("Incorrect Info!")
        }
    }
    
    @IBAction func dogsBtnPressed(_ sender: Any) {
        
        if checkDogInputs() {
            signUpProgBar.animate(duration: 0.5, value: Float(0.82))
            signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width * 2, y: 0), animated: true)
            pageNumber = 2
        } else {
            print("Incorrect Info!")
        }
    }
    
}

extension UIProgressView {
    func animate(duration: Double, value: Float) {
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
            self.setProgress(value, animated: true)
        }, completion: nil)
    }
}
