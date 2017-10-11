//
//  ProfileVC.swift
//  Fetch
//
//  Created by Pablo Garces on 10/11/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var imageBack: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    @IBOutlet weak var postsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageBack.layer.cornerRadius = 40
        profileImg.layer.cornerRadius = 36
        profileImg.layer.masksToBounds = true
        editBtn.layer.cornerRadius = 6
        editBtn.layer.masksToBounds = true
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        dogsCollectionView.delegate = self
        dogsCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileDog", for: indexPath) as! ProfileDogCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileImgRow", for: indexPath) as! ProfileListCell
        
        return cell
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
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
