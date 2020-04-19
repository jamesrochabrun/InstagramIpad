//
//  Tools.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/2/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var random: UIColor {
        return .init(hue: .random(in: 0...1),
                     saturation: 1,
                     brightness: 1,
                     alpha: 1)
    }
}


extension UIView {
    
    func circle(_ frame: CGRect? = nil) {
    self.layer.cornerRadius = (frame ?? self.frame).width / 2
    self.layer.masksToBounds = false
     //   layer.borderColor = UIColor.white.cgColor
      //  layer.borderWidth = 3.0
    self.clipsToBounds = true
  }
}
