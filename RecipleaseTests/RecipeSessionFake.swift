//
//  URLSessionFake.swift
//  RecipleaseTests
//
//  Created by Frédéric PICHOT on 24/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//
@testable import Reciplease
import Foundation
import Alamofire


class RecipeSessionFake: RecipeProtocol {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let result: Result<Any>
        let urlRequest = URLRequest(url: URL(string: "https://openclassrooms.com")!)
        
        if let requestError = error {
            result = .failure(requestError)
        } else {
            result = .success("success")
        }
        
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
