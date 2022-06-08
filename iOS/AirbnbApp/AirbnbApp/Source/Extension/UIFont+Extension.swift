//
//  UIFont+Extension.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit.UIFont

extension UIFont {
    
    enum NotoSans {
        static let medium = UIFont(name: .Font.NotoSansKRMedium, size: 17)
        static let regular = UIFont(name: .Font.NotoSansKRRegular, size: 17)
    }
    
    enum SFProDisplay {
        static let medium = UIFont(name: .Font.SFProDisplayMedium, size: 34)
        static let regular: (CGFloat) -> UIFont? = { (size) -> UIFont? in
            UIFont(name: .Font.SFProDisplayRegular, size: size)
        }
        static let semiBold = UIFont(name: .Font.SFProDisplaySemibold, size: 17)
        static let bold: (CGFloat) -> UIFont? = { (size) -> UIFont? in
            UIFont(name: .Font.SFProDisplayBold, size: size)
        }
        
    }
    
}

private extension String {
    enum Font {
        static let NotoSansKRMedium = "NotoSansKR-Medium"
        static let NotoSansKRRegular = "NotoSansKR-Regular"
        static let SFProDisplayMedium = "SFProDisplay-Medium"
        static let SFProDisplayRegular = "SFProDisplay-Regular"
        static let SFProDisplaySemibold = "SFProDisplay-Semibold"
        static let SFProDisplayBold = "SFProDisplay-Bold"
    }
}
