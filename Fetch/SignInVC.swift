//
//  SignInVC.swift
//  Fetch
//
//  Created by Pablo Garces on 9/15/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollViewIntro: UIScrollView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInLbl: UILabel!
    
    
    let mainBlue = UIColor(red: 84/255, green: 157/255, blue: 214/255, alpha: 1)
    let textColor = UIColor(red: 167/255, green: 169/255, blue: 172/255, alpha: 1)
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.pageIndicatorTintColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        pc.currentPageIndicatorTintColor = UIColor(red: 84/255, green: 157/255, blue: 214/255, alpha: 1)
        return pc
    }()
    let IntroTitlesArray:[String] = ["This is the first description",
                                     "Here is the second one",
                                     "This is the third"]
    
    var contentWidth: CGFloat = 0.0
    var newX: CGFloat = 0.0
    var totalWidth: CGFloat = 0.0
    var IntroImages = [UIImageView]()
    let labelTitle = UILabel()
    var pageNumber = 0
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewIntro.delegate = self
        scrollViewIntro.showsHorizontalScrollIndicator = false
        scrollViewIntro.isPagingEnabled = true
        let height = view.frame.size.height
        
        signInBtn.layer.cornerRadius = 6
        signInBtn.backgroundColor = mainBlue
        signUpBtn.titleLabel?.textColor = mainBlue
        signInLbl.textColor = textColor
        
        view.addSubview(pageControl)
        
        var x = 0
        
        while x <= 2 {
            
            var imageView = UIImageView()
            let image = UIImage(named: "intro\(x)")
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            IntroImages.append(imageView)
            scrollViewIntro.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            
            newX = view.frame.midX + view.frame.size.width * CGFloat(x)
            contentWidth += newX
            
            labelTitle.textAlignment = .center
            labelTitle.textColor = textColor
            labelTitle.font = UIFont(name: "Helvetica-Neue", size: 18.0)
            labelTitle.text = IntroTitlesArray[pageNumber]
            view.addSubview(labelTitle)
            
            labelTitle.frame = CGRect(x: view.frame.midX - 150, y: (view.frame.size.height / 2) + 100, width: 300, height: 25)
            
            imageView.frame = CGRect(x: newX - (view.frame.size.width / 2), y: 0, width: view.frame.size.width, height: scrollViewIntro.frame.size.height)
            
            if (height > 670) {
                //labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 100, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 50, width: 100, height: 30)
                print("Case one. Big screen")
                
                
            } else if (height > 570 && height < 670) {
                //labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 110, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 60, width: 100, height: 30)
                print("Case two. Medium screen")
                
            } else {
                //labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 75, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 38, width: 100, height: 30)
                print("Case three. Small screen")
                
            }
            
            print(x)
            x += 1
            
        }
        
        totalWidth = view.frame.size.width * 3
        print(totalWidth)
        scrollViewIntro.contentSize = CGSize(width: totalWidth, height: scrollViewIntro.frame.size.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        pageNumber = Int(targetContentOffset.pointee.x / view.frame.size.width)
        pageControl.currentPage = pageNumber
        print(pageNumber)
        
        fadeViewOutThenIn(view: labelTitle, delay: 0.0)
        
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.labelTitle.text = self.IntroTitlesArray[self.pageNumber]
        }
        
    }
    
    func fadeViewOutThenIn(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.25

        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 0
        }) { (Bool) -> Void in
            
            UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: { () -> Void in
                view.alpha = 1
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goSignUp", sender: self)
    }

    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goSignIn", sender: self)
    }
}
