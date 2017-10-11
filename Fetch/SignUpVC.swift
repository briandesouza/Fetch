//
//  SignUpVC.swift
//  Fetch
//
//  Created by Pablo Garces and Brian De Souza on 10/8/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit
import Firebase

var indexPressed: Int = 0

class SignUpVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, AddRowDelegate {
    
    
    // --- IBs
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
    @IBOutlet weak var dogsBtn: UIButton!
    @IBOutlet weak var profilePicBack: UIView!
    @IBOutlet weak var profilePicImg: UIImageView!
    @IBOutlet weak var profileCircBack: UIView!
    @IBOutlet weak var profileCircImg: UIImageView!
    @IBOutlet weak var youLbl: UILabel!
    @IBOutlet weak var dogsLbl: UILabel!
    @IBOutlet weak var topHeader: UIView!
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    // --- Views
    var nextBtn = UIButton()
    var imagePicker = UIImagePickerController()
    var dogsTableView = UITableView()
    // --- Numbers
    var kbHeight: CGFloat!
    var pageNumber = 0
    var numDogs = 4
    // --- Bools
    var firstTimeOpen = false
    var firstAnimation = false
    
    // --- Firebase
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        signUpScrollView.delegate = self
        signUpScrollView.alwaysBounceHorizontal = false
        signUpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        signUpScrollView.contentSize = CGSize(width: view.frame.size.width * 2, height: signUpScrollView.frame.size.height)
        
        signUpProgBack.layer.cornerRadius = 5
        signUpProgBack.layer.masksToBounds = true
        
        profilePicBack.layer.cornerRadius = 50
        profilePicImg.layer.cornerRadius = 46
        profilePicImg.layer.masksToBounds = true
        
        profileCircBack.layer.cornerRadius = 16
        profileCircImg.layer.cornerRadius = 13
        
        signUpProgBar.progressViewStyle = .bar
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
        
        youLbl.font = UIFont(name: "Avenir-Heavy", size: 16.0)
        
        // Create Dog Table View
        dogsTableView.frame = CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height - (topHeader.frame.size.height + topLine.frame.size.height + nextBtn.frame.size.height + 20))
        dogsTableView.delegate = self
        dogsTableView.dataSource = self
        dogsTableView.backgroundColor = UIColor.red
        dogsTableView.register(UINib(nibName: "AddDogCell", bundle: nil), forCellReuseIdentifier: "dogCell")
        dogsTableView.register(UINib(nibName: "AddRowCell", bundle: nil), forCellReuseIdentifier: "addRow")
        //dogsTableView.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
        //dogsTableView.rowHeight = UITableViewAutomaticDimension
        dogsTableView.allowsSelection = false
        //dogsTableView.estimatedRowHeight = 300
        dogsTableView.separatorStyle = .none
        dogsTableView.showsVerticalScrollIndicator = false
        signUpScrollView.addSubview(dogsTableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        
        if !firstAnimation {
            
            animateTextFields()
            firstAnimation = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //pageNumber = Int(signUpScrollView.contentOffset.x / view.frame.size.width)
    }
    
    func createAcct(){
        Auth.auth().createUser(withEmail: emailField.text!.lowercased(), password: passField.text!) { (user, error) in
            if(error != nil){
                if Auth.auth().currentUser == nil {
                     self.nextBtn.setTitle("\(String(describing: error!.localizedDescription))", for: .normal) //This is the error description
                }
                return
                //handles error
            }
            
            //Sets user's private values in the database
            self.ref.child("users").child((user?.uid)!).child("username").setValue(self.usernameField.text)
            self.ref.child("users").child((user?.uid)!).child("name").setValue(self.nameField.text?.capitalized)
            self.ref.child("users").child((user?.uid)!).child("phone").setValue(self.phoneField.text)
            self.ref.child("users").child((user?.uid)!).child("city").setValue(self.self.cityField.text?.capitalized)
            
            
            //Uploading Profile image to Firebase Storage
            if self.profilePicImg.image != nil {
                let storage = Storage.storage()
                let storageRef = storage.reference().child("profiles/\(String(describing: self.usernameField.text!))/\(String(describing: self.usernameField.text!)).png")
                if let uploadData = UIImagePNGRepresentation(self.profilePicImg.image!){
                    storageRef.putData(uploadData, metadata: nil , completion: { (metadata, error) in
                        if error != nil{
                            print(error.debugDescription)
                            return
                        }
                        
                        //Saves Photo URL to users firebae profile
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = self.nameField.text?.capitalized
                        changeRequest?.photoURL = metadata?.downloadURL()!
                        changeRequest?.commitChanges { (error) in
                        }
                    })
                }
            }
        }
        
    }
    
    func saveDogsDB(){
        
        //let dogName = Get dog name
        //let dogAge = Get dog age
        
        let storage = Storage.storage()
        for x in 0..<numDogs{
            
            let uniqueID = NSUUID().uuidString
            //Store Image
            /*
            let storageRef = storage.reference().child("profiles/\(String(describing: self.usernameField.text!))/uniqueID.png")
            if let uploadData = UIImagePNGRepresentation(self.profilePicImg.image!){
                storageRef.putData(uploadData, metadata: nil , completion: { (metadata, error) in
                    if error != nil{
                        print(error.debugDescription)
                        return
                    }
             
                     let dogImageURl = String(contentsOf: metadata?.downloadURL()!)
                     self.ref.child("users").child((user?.uid)!).child("dogs/\(uniqueID)/name").setValue(dogName)
                     self.ref.child("users").child((user?.uid)!).child("dogs/\(uniqueID)/imageURL").setValue(dogImageURL)
                     self.ref.child("users").child((user?.uid)!).child("dogs/\(uniqueID)/age").setValue(dogAge)
             
                    }
                })
            }
         */
        
        }
    }
    
    @objc func checkInputs() -> Bool {
        
        //Check If All Fields Are Filled
        if(emailField.text!.lowercased() == ""){
            self.nextBtn.setTitle("Email Not Inserted", for: .normal)
            return false
        }
        if(nameField.text == ""){
            self.nextBtn.setTitle("Name Not Inserted", for: .normal)
            return false
        }
        if(phoneField.text == ""){
            self.nextBtn.setTitle("Phone Not Inserted", for: .normal)
            return false
        }
        if(cityField.text == ""){
            self.nextBtn.setTitle("City Not Inserted", for: .normal)
            return false
        }
        if(usernameField.text == ""){
            self.nextBtn.setTitle("City Not Inserted", for: .normal)
            return false
        }
        
        //Check if password match
        if(passField.text! != conPassField.text){
            self.nextBtn.setTitle("Passwords Do Not Match", for: .normal)
            return false
        }
        
        self.nextBtn.setTitle("NEXT", for: .normal)
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
            self.signUpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            
        })
    }
    
    func abc123(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func animateTextFields() {
        
        nameField.alpha = 0.0
        nameField.transform = CGAffineTransform(translationX: 0, y: 10)
        emailField.alpha = 0.0
        emailField.transform = CGAffineTransform(translationX: 0, y: 10)
        phoneField.alpha = 0.0
        phoneField.transform = CGAffineTransform(translationX: 0, y: 10)
        usernameField.alpha = 0.0
        usernameField.transform = CGAffineTransform(translationX: 0, y: 10)
        cityField.alpha = 0.0
        cityField.transform = CGAffineTransform(translationX: 0, y: 10)
        passField.alpha = 0.0
        passField.transform = CGAffineTransform(translationX: 0, y: 10)
        conPassField.alpha = 0.0
        conPassField.transform = CGAffineTransform(translationX: 0, y: 10)
        
        UIView.animate( withDuration: 0.6, delay: 0.0, animations: {
            
            self.nameField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.nameField.alpha = 1.0
        }, completion: { finished in
            
        })
        
        UIView.animate( withDuration: 0.6, delay: 0.2, animations: {
            
            self.emailField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.emailField.alpha = 1.0
        }, completion: { finished in
                            
        })
        
        UIView.animate( withDuration: 0.6, delay: 0.4, animations: {
            
            self.phoneField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.phoneField.alpha = 1.0
        }, completion: { finished in
            
        })
        
        UIView.animate( withDuration: 0.6, delay: 0.4, animations: {
            
            self.usernameField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.usernameField.alpha = 1.0
        }, completion: { finished in
            
        })
        
        UIView.animate( withDuration: 0.6, delay: 0.6, animations: {
            
            self.cityField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.cityField.alpha = 1.0
        }, completion: { finished in
            
        })
        
        UIView.animate( withDuration: 0.6, delay: 0.8, animations: {
            
            self.passField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.passField.alpha = 1.0
        }, completion: { finished in
            
        })
        
        UIView.animate( withDuration: 0.6, delay: 1.0, animations: {
            
            self.conPassField.transform = CGAffineTransform(translationX: 0, y: 0)
            self.conPassField.alpha = 1.0
        }, completion: { finished in
            
        })
        
    }
    
    @objc func nextBtnPressed() {
        
        if pageNumber == 0 {
            
            if checkInputs() {
                
                print("Good Profile Info!")
                youLbl.font = UIFont(name: "Avenir-Medium", size: 16.0)
                dogsLbl.font = UIFont(name: "Avenir-Heavy", size: 16.0)
                signUpProgBar.animate(duration: 0.5, value: Float(0.75))
                signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
                signUpScrollView.isScrollEnabled = false
                //Changes Page
                pageNumber = 1
                
            } else {
                
                print("Incorrect Info!")
            }
            
        } else {
            
            //Check Dog Input()
            
            self.createAcct()
            
            sleep(2)
            
            if Auth.auth().currentUser != nil {
                performSegue(withIdentifier: "goTabs", sender: self)
            }
            
            // Segue Here if Dog Info is Good
            
        }
        
        print("After: ", pageNumber)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numDogs + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < numDogs {
            let dogCell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath) as! AddDogCell
            
            dogCell.cellNumberLbl.text = "\(indexPath.row + 1)"
            dogCell.dogImgBtn.tag = indexPath.row
            dogCell.index = indexPath.row
            
            return dogCell
            
        } else {
            let addCell = tableView.dequeueReusableCell(withIdentifier: "addRow", for: indexPath) as! AddRowCell
            
            return addCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row < numDogs {
            return 315
            
        } else {
            return 80
        }
    }
    
    func addRowBtnTapped() {
        
        numDogs = numDogs + 1
        
        dogsTableView.beginUpdates()
        dogsTableView.insertRows(at: [
            NSIndexPath(row: numDogs, section: 0) as IndexPath
            ], with: .automatic)

        dogsTableView.endUpdates()
        
        print("NUM DOGS: ", numDogs)
    }
    
    @IBAction func youBtnPressed(_ sender: Any) {
        
        signUpScrollView.isScrollEnabled = true
        signUpProgBar.animate(duration: 0.5, value: Float(0.25))
        signUpScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        pageNumber = 0
        
        youLbl.font = UIFont(name: "Avenir-Heavy", size: 16.0)
        dogsLbl.font = UIFont(name: "Avenir-Medium", size: 16.0)
    }
    
    @IBAction func dogsBtnPressed(_ sender: Any) {
        
        if checkInputs() {
            
            signUpProgBar.animate(duration: 0.5, value: Float(0.75))
            signUpScrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: true)
            pageNumber = 1
            signUpScrollView.isScrollEnabled = false
            
            youLbl.font = UIFont(name: "Avenir-Medium", size: 16.0)
            dogsLbl.font = UIFont(name: "Avenir-Heavy", size: 16.0)
            
        } else {
            print("Incorrect Info!")
        }
    }
    
    @IBAction func chooseProfilePicBtnPressed(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func skipBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goTabs", sender: self)
    }
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicImg.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
