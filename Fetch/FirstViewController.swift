//
//  FirstViewController.swift
//  Fetch
//
//  Created by Brian Nunes De Souza on 9/15/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        //FIRAuth?.addStateDidChangeListener{ (auth, user) in
            // ...
        }
    }


}

