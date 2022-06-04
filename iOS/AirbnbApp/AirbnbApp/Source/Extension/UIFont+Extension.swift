//
//  UIFont+Extension.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit.UIFont

extension UIFont {
    
    enum NotoSans {
        static let medium = UIFont(name: "NotoSansKR-Medium", size: 17)
        static let regular = UIFont(name: "NotoSansKR-Regular", size: 17)
    }
    
    enum SFProDisplay {
        static let medium = UIFont(name: "SFProDisplay-Medium", size: 34)
        static let regular: (CGFloat) -> UIFont? = { (size) -> UIFont? in
            UIFont(name: "SFProDisplay-Regular", size: size)
        }
        static let semiBold = UIFont(name: "SFProDisplay-Semibold", size: 17)
        static let bold: (CGFloat) -> UIFont? = { (size) -> UIFont? in
            UIFont(name: "SFProDisplay-Bold", size: size)
        }
        
    }
    
}
