//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Frédéric PICHOT on 11/10/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//

import Foundation

struct FakeResponse {
    
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}
