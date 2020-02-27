//
//  CellTableView.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import UIKit

protocol ConfigurationCellRecipe {
    func imageRecipe (url : String)
    func setTitle (title : String)
    func setSource (source : String)
    func setHealthLabel (health : [String])
}


class CellTableViewRecipe : UITableViewCell {
    
    private let imageViewRecipe : UIImageView = {
       let i = UIImageView ()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    private let LabelTitle : UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let labelSource : UILabel = {
       let l = UILabel ()
        return l
    }()
    
    private let labelHealth : UILabel = {
       let l = UILabel ()
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
       return l
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        self.selectionStyle = .none
        addViews()
    }
    
    private func addViews () {
        self.contentView.addSubview(imageViewRecipe)
        self.contentView.addSubview(LabelTitle)
        self.contentView.addSubview(labelSource)
        self.contentView.addSubview(labelHealth)
        
        imageViewRecipe.anchor(top: contentView.topAnchor , leading: contentView.leadingAnchor  , paddingTop: 8, paddingLeft: 8 , paddingBottom: 8 , width: 80 , height: 80  )
      //  imageViewRecipe.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor , constant: -8 ).isActive = true
        
        LabelTitle.anchor(top: imageViewRecipe.topAnchor , leading: imageViewRecipe.trailingAnchor , trailing: contentView.trailingAnchor , paddingLeft: 16 , paddingRight: 16 )
        labelSource.anchor(top: LabelTitle.bottomAnchor , leading: LabelTitle.leadingAnchor , trailing: contentView.trailingAnchor , paddingTop: 8 , paddingBottom: 16 )
        labelHealth.anchor(top: labelSource.bottomAnchor , leading: labelSource.leadingAnchor , bottom: contentView.bottomAnchor , trailing: contentView.trailingAnchor , paddingTop: 8 , paddingBottom: 8 , paddingRight: 16 )
     
    }
    
    
}

extension CellTableViewRecipe : ConfigurationCellRecipe {
    func imageRecipe(url: String) {
        self.imageViewRecipe.loadImage(url: url )
    }
    
    func setTitle(title: String) {
        self.LabelTitle.text = title
    }
    
    func setSource(source: String) {
        self.labelSource.text = source
    }
    
    func setHealthLabel(health: [String]) {
        var s = ""
        health.forEach { (str) in
            if s == "" {
                s = str
            }else {
                s += "\n\(str)"
            }
        }
        self.labelHealth.text = s
    }
    
    
}
