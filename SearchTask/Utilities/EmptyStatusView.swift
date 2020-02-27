//
//  EmptyStatusView.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import UIKit

class EmptyStatusView : UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }

    lazy var emptyImage : UIImageView = {
       let i = UIImageView()
        return i
    }()
    
    lazy var labelEmpty : UILabel = {
       let l = UILabel()
     //   l.font = Fonts.fontLight(size: Dimensions.fontMedium )
        l.textAlignment = .center
        return l
    }()
    
    lazy var button : UIButton = {
       let b = UIButton()
        b.isHidden = true
        return b
    }()
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        
        self.addSubview(emptyImage)
        self.addSubview(labelEmpty)
        self.addSubview(button)
        
        emptyImage.anchor( centerX: self.centerXAnchor , centerY: self.centerYAnchor ,  width: 150 , height: 150 )
        labelEmpty.anchor(top: emptyImage.bottomAnchor , leading: self.leadingAnchor , trailing: self.trailingAnchor , paddingTop: 16 , paddingLeft: 16 , paddingRight: 16 )
        
        button.anchor(top: labelEmpty.bottomAnchor  , centerX: labelEmpty.centerXAnchor , paddingTop: 16 , paddingBottom: 8 )
        
    }
    
    func hideButton (){
        button.isHidden = true
    }
    
    func showButton (title : String? = nil  , image : UIImage? = nil ) {
//        if let t = title {
//           // button.setTitle(title: t)
//        }
//        if let i = image {
//            //button.setImage(image: i)
//        }
        button.isHidden = false
    }
    
    
    func setDataLoginFirst() {
        self.isHidden = false
        //self.emptyImage.image = #imageLiteral(resourceName: "cartEmpty")
        self.labelEmpty.text = ""
       // self.showButton(title: SString.pleaseLoginFirst  )
               
    }
    
    func setData (text : String , image : UIImage) {
        self.emptyImage.image = image
        self.labelEmpty.text = text
    }
    
    
}
