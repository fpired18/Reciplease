//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Frédéric PICHOT on 11/10/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
