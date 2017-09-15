//
//  SignInVC.swift
//  Fetch
//
//  Created by Pablo Garces on 9/15/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollViewIntro: UIScrollView!
    
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 8
        pc.pageIndicatorTintColor = UIColor(colorLiteralRed: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        pc.currentPageIndicatorTintColor = UIColor(red: 70/255, green: 166/255, blue: 146/255, alpha: 1)
        return pc
    }()
    let IntroTitlesArray:[String] = ["This is the first description",
                                     "Here is the second one",
                                     "This is the third"]
    
    var contentWidth: CGFloat = 0.0
    var newX: CGFloat = 0.0
    var totalWidth: CGFloat = 0.0
    var IntroImages = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollViewIntro.delegate = self
        let height = view.frame.size.height
        
        view.addSubview(pageControl)
        
        var x = 0
        
        while x <= 7 {
            
            var imageView = UIImageView()
            let image = UIImage(named: "intro\(x)")
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            IntroImages.append(imageView)
            scrollViewIntro.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            
            newX = view.frame.midX + view.frame.size.width * CGFloat(x)
            contentWidth += newX
            
            let labelTitle = UILabel()
            labelTitle.textAlignment = .center
            labelTitle.textColor = UIColor(red: 65/255, green: 64/255, blue: 66/255, alpha: 1)
            labelTitle.text = IntroTitlesArray[x]
            labelTitle.font = UIFont(name: "Helvetica", size: 18.0)
            view.addSubview(labelTitle)
            
            imageView.frame = CGRect(x: newX - (view.frame.size.width / 2), y: 0, width: view.frame.size.width, height: view.frame.size.height)
            
            if (height > 670) {
                labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 100, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 50, width: 100, height: 30)
                print("Case one. Big screen")
                
                
            } else if (height > 570 && height < 670) {
                labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 110, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 70, width: 100, height: 30)
                print("Case two. Medium screen")
                
            } else {
                labelTitle.frame = CGRect(x: newX - 150, y: (view.frame.size.height / 2) + 75, width: 300, height: 25)
                
                pageControl.frame = CGRect(x: (view.frame.size.width / 2) - 50, y: (view.frame.size.height / 2) + 38, width: 100, height: 30)
                print("Case three. Small screen")
                
            }
            
            print(x)
            x += 1
            
        }
        
        totalWidth = view.frame.size.width * 8
        print(totalWidth)
        scrollViewIntro.contentSize = CGSize(width: totalWidth, height: height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
