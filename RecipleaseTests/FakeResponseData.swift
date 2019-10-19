//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Frédéric PICHOT on 24/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation

class  FakeResponseData {
    static var changeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let changeIncorrectData = "erreur".data(using: .utf8)!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class RecipeError: Error {}
    static let error = RecipeError()
}
