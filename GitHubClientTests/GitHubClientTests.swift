//
//  GitHubClientTests.swift
//  GitHubClientTests
//
//  Created by Sergey on 24/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import XCTest
import PromiseKit
@testable import GitHubClient

class GitHubClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    
        let ex = expectationWithDescription("")
        
        firstly {
            
            return GitHubApi().obtainRepositoriesForUser("MacKudos")
            
            }.then { (op:[ObtainRepositroiesResponse]) -> Promise<[ObtainRepositroiesResponse]> in
                
                debugPrint(op)
                return GitHubApi().obtainRepositoriesForUser("MacKudos")
        
            }.then { (op:[ObtainRepositroiesResponse]) -> Void in
                
                debugPrint(op)
                ex.fulfill()
                
            }.error { (er:ErrorType) -> Void in
                
                debugPrint(er)
                XCTFail()
        }
    }
    
    func testPerformanceExample() {
        self.measureBlock {
        }
    }
    
}
