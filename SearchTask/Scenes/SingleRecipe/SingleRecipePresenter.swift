//
//  SingleRecipePresenter.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/26/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//VC


protocol ProSingleRecipeView : StatusApi {
    
}

protocol ProSingleRecipePresetner {

    
}


class SingleRecipePresenter : ProSingleRecipePresetner {
    
    weak var view : ProSingleRecipeView?
    private let interactor = SingleRecipeInteractor()
    
    init(view : ProSingleRecipeView ) {
        self.view = view
    }
    
}
