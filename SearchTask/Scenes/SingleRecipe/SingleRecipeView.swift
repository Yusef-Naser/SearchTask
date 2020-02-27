//
//  SingleRecipeView.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/26/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//VC

import UIKit


class SingleRecipeView : UIView {
    
    lazy var scrollView : UIScrollView = {
        let s = UIScrollView()
        s.addSubview(viewContainerInScrollView)
        viewContainerInScrollView.anchor(top: s.topAnchor , leading: s.leadingAnchor , bottom: s.bottomAnchor , trailing: s.trailingAnchor )
        viewContainerInScrollView.widthAnchor.constraint(equalTo: s.widthAnchor , multiplier: 1).isActive = true
        return s
    }()
    
    let viewContainerInScrollView = UIView()
    
    let imageViewRecipe : UIImageView = {
       let i = UIImageView ()
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    let labelTitle : UILabel = {
       let l = UILabel ()
        l.font = UIFont.systemFont(ofSize: 30 )
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    let labelIngredient : UILabel = {
       let l = UILabel ()
        l.text = "Ingredient Lines"
        l.font = UIFont.systemFont(ofSize: 25 )
        return l
    }()
    
    let labelIngredientLines : UILabel = {
        let l = UILabel ()
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    let urlLabel : UILabel = {
       let l = UILabel ()
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.textColor = .blue
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        
        self.addSubview(scrollView)
        viewContainerInScrollView.addSubview(imageViewRecipe)
        viewContainerInScrollView.addSubview(labelTitle)
        viewContainerInScrollView.addSubview(labelIngredient)
        viewContainerInScrollView.addSubview(labelIngredientLines)
        viewContainerInScrollView.addSubview(urlLabel)
        
        if #available(iOS 11.0, *) {
            scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor , leading: self.leadingAnchor , bottom: self.bottomAnchor , trailing: self.trailingAnchor )
        }else {
             scrollView.anchor(top: self.topAnchor , leading: self.leadingAnchor , bottom: self.bottomAnchor , trailing: self.trailingAnchor )
        }
        
        
        imageViewRecipe.anchor(top: viewContainerInScrollView.topAnchor , centerX: viewContainerInScrollView.centerXAnchor , paddingTop: 20 , width: 150 , height: 150 )
        
        labelTitle.anchor(top: imageViewRecipe.bottomAnchor , leading: viewContainerInScrollView.leadingAnchor , trailing: viewContainerInScrollView.trailingAnchor, centerX: viewContainerInScrollView.centerXAnchor , paddingTop: 30 )
        
        labelIngredient.anchor(top: labelTitle.bottomAnchor , leading: viewContainerInScrollView.leadingAnchor  , paddingTop: 50 , paddingLeft: 16 )
        
        labelIngredientLines.anchor(top: labelIngredient.bottomAnchor , leading: viewContainerInScrollView.leadingAnchor , trailing: viewContainerInScrollView.trailingAnchor , paddingTop: 50 , paddingLeft: 16 , paddingBottom: 16 , paddingRight: 16 )
        
        urlLabel.anchor(top: labelIngredientLines.bottomAnchor , leading: viewContainerInScrollView.leadingAnchor , bottom: viewContainerInScrollView.bottomAnchor , trailing: viewContainerInScrollView.trailingAnchor , paddingTop: 50 , paddingLeft: 20 , paddingBottom: 50 , paddingRight: 20 )
        
        
        
    }
    
    
}
