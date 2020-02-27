//
//  ModelSearch.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/26/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import Foundation

struct ModelSearch: Codable {
    let q: String?
    let from, to: Int?
    let more: Bool?
    let count: Int?
    let hits: [ModelProduct]?
    
    let status : String?
    let message : String?
    
}

struct ModelProduct: Codable {
    let recipe: ModelRecipe?
    let bookmarked, bought: Bool?
}


struct ModelRecipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
    let ingredients: [ModelIngredient]?
    let calories, totalWeight: Double?
    let totalTime: Int?
    let totalNutrients, totalDaily: [String: ModelTotal]?
    let digest: [ModelDigest]?
}

// MARK: - Digest
struct ModelDigest: Codable {
    let label, tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: String?
    let sub: [ModelDigest]?
}

struct ModelIngredient: Codable {
    let text: String?
    let weight: Double?
}

struct ModelTotal: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}
