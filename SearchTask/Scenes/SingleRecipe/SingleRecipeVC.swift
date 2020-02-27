//
//  SingleRecipeVC.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/26/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import UIKit
import SafariServices

class SingleRecipeVC : BaseVC<SingleRecipeView> {
    
    private var presenter : ProSingleRecipePresetner?
    
    private var recipeObject : ModelRecipe?
    
    init(recipe : ModelRecipe?) {
        super.init(nibName: nil , bundle: nil )
        self.recipeObject = recipe
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = SingleRecipePresenter(view : self )
        
        mainView.imageViewRecipe.loadImage(url: recipeObject?.image ?? "" )
        mainView.labelTitle.text = recipeObject?.label ?? ""
        
        var s = ""
        recipeObject?.ingredientLines?.forEach({ (str) in
            if s == "" {
                s = str
            }else {
                s += "\n\n\(str)"
            }
        })
        mainView.labelIngredientLines.text =  s
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: recipeObject?.url ?? "" , attributes: underlineAttribute)
        mainView.urlLabel.attributedText = underlineAttributedString
        
        mainView.urlLabel.isUserInteractionEnabled = true
        mainView.urlLabel.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(actionUrlLabel)))
        
    }
    
    @objc private func actionUrlLabel () {
        if let url = URL(string: mainView.urlLabel.text ?? "" ) {
            let vc = SFSafariViewController( url: url )
            present(vc, animated: true)
        }
    }
    
    
}

extension SingleRecipeVC : ProSingleRecipeView {
    
}
