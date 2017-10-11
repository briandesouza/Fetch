//
//  Extension.swift
//  Fetch
//
//  Created by Brian Nunes De Souza on 10/11/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {
    func animate(duration: Double, value: Float) {
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
            self.setProgress(value, animated: true)
        }, completion: nil)
    }
}
