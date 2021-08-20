//
//  CityDetailsTests.swift
//  CityDetailsTests
//
//  Created by Kashish Rastogi on 30/07/21.
//

import XCTest
@testable import CityDetails

class CityDetailsTests: XCTestCase {

    
    
    func textUI() throws
    {
        measure {
            let app = XCUIApplication();
            app.launch()
            let a = 5,b = 10
            XCTAssertTrue(a>b)
            
        }
        
        
    }
    
    func testBool()
    {
        let a = 5,b = 10
        XCTAssertFalse(a>b)

    }
    
    func testXYZ()
    {
        let a = "abhi"
        XCTAssertNotNil(a)
    }
    
    
    
    func testApi()
    {
        measure
        {
        let expectation = XCTestExpectation(description: "Download apple.com home page")

        let parser =  WeatherDetailsParser();
        parser.GetWeatherDetails(latitude: 22.44, longitude: 147) { (object, error) in
            if error == nil
            {
                if let weatherObj:WeatherAPIDetailsBO = object
                {
                    print(weatherObj.name)
                    expectation.fulfill()

                }
            }
        }
        wait(for: [expectation], timeout: 20.0)
        
            
        }

    }

  

}
