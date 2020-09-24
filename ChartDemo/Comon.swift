//
//  Comon.swift
//  ChartDemo
//
//  Created by Mahendra Vishwakarma on 24/09/20.
//  Copyright © 2020 Mahendra. All rights reserved.
//

import Foundation
import  UIKit

extension UIView {
    func addBtnGradient(_ identifier:String = "GradientName" ,gradientColor:UIColor = AppColors.voiletColorDark , lightColor:UIColor = AppColors.voiletColorLight,  cornerRadius : CGFloat = 0.0 ,width : CGFloat = 0.0)  {
        let gradient = CAGradientLayer()
        var gradientFrame1 = self.bounds
        if width > 0.0 {
            gradientFrame1.size.width = width
        }else{
            gradientFrame1.size.width = self.frame.size.width
        }
        gradient.frame = gradientFrame1
        gradient.name = identifier
        gradient.startPoint = CGPoint(x: 0.0, y: 0.7)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.7)
        gradient.cornerRadius = cornerRadius
        gradient.colors = [gradientColor.cgColor, lightColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
   
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 4
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 7
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


struct AppColors {
    static let voiletColorDark = UIColor.init(hexStr: "#7127E0")
    static let voiletColorLight = UIColor.init(hexStr: "#A43AD0")
    static let blueColorDark = UIColor.init(hexStr: "#0400A3")
    static let blueColorLight = UIColor.init(hexStr: "#6BACDF")
    static let yellowDark = UIColor.init(hexStr: "#F7AB2B")
    static let yellowLight = UIColor.init(hexStr: "#FFC86B")
    
    static let greenDark = UIColor.init(hexStr: "#26A8D1")
    static let greenLight = UIColor.init(hexStr: "#3DC8E8")
    
}



//MARK: - UIColor
extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    
    convenience init (hexStr: String){
        var cString: String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1)
        
    }
}


