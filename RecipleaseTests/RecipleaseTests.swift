//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Frédéric PICHOT on 13/09/2019.
//  Copyright © 2019 Frédéric PICHOT. All rights reserved.
//
@testable import Reciplease
import XCTest
import Alamofire

class RecipleaseTests: XCTestCase {
    var fakeResponse: FakeResponse!
    var recipeSessionFake: RecipeSessionFake!
    var recipeService: RecipeService!
    let recipeServices = RecipeService.self
    let recipeFavorite = RecipeFavorite.all
    override func setUp() {
        super.setUp()
        fakeResponse = FakeResponse()
        recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        recipeService = RecipeService(recipeSession: recipeSessionFake)
    }
    //let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
    
    func testSizeImageAfterShouldResizeImageWithGoodCgsize() {
        
        //When
        if let imageData = recipeFavorite[0].imageData {
            let imageUimage = UIImage(data: imageData)!
            let picture = RecipeService.resizeImage(image: imageUimage, targetSize: CGSize.init(width: 200, height: 200))
            
        //Then
            XCTAssertNotEqual(imageUimage, picture)
        }
    }
    
    func testSizeImageAfterShouldResizeImageWithBadCgsize() {
        
        //When
        if let imageData = recipeFavorite[0].imageData {
            let imageUimage = UIImage(data: imageData)!
            let picture = RecipeService.resizeImage(image: imageUimage, targetSize: CGSize.init(width: 200, height: 50))
            
            //Then
            XCTAssertNotEqual(imageUimage, picture)
        }
    }
    
    func testCompleteUrlIfRecipeUrlNoStringThenCompleteUrlReturn() {
        
    }
    
    func testGetStringShouldPostFloatTimePreparationLessSixtyMinutes() {
        //Given
        let timeTotal: Float = 45.5
        
        //When
        let totalTimeString = recipeServices.timePreparation(preparationTime: timeTotal)
        
        //Then
        XCTAssertEqual(totalTimeString, "46m")
    }
    
    func testGetStringShouldPostFloatTimePreparationMoreSixtyMinutes() {
        //Given
        let timeTotal: Float = 66.5
        
        //When
        let totalTimeString = recipeServices.timePreparation(preparationTime: timeTotal)
        
        //Then
            XCTAssertEqual(totalTimeString, "1h6 m")
    }

    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        //Given
        fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipeStruct)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        //Given
        fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.changeIncorrectData,
                                        error: nil)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then
            
            XCTAssertFalse(success)
            XCTAssertNil(recipeStruct)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfResponseKO() {
        
        //Given
        fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.changeCorrectData,
                                        error: nil)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then

            XCTAssertFalse(success)
            XCTAssertNil(recipeStruct)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        //Given
        fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipeStruct)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipShouldPostSuccessCallbackIfNoErrorWithCorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.changeIncorrectData,
                                        error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then
            XCTAssertNotNil(success)
            XCTAssertTrue((recipeStruct == nil))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfError() {
        //Given
        fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeService.getRecipe(valueEntered: "rabbit") { (success, recipeStruct) in
            
        //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipeStruct)
            expectation.fulfill()
        }
        //wait(for: [expectation], timeout: 0.01)
    }
}
