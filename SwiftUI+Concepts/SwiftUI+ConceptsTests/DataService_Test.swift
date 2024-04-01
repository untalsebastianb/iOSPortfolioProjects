//
//  DataService_Test.swift
//  SwiftUI+ConceptsTests
//
//  Created by Juan Sebastian Bueno on 3/31/24.
//

import XCTest
@testable import SwiftUI_Concepts
import Combine

final class DataService_Test: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_DataService_init_doesSetValuesCorrectl() {
        // given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        // when
        let dataService = NewMockDataService(items: items)
        let dataservice2 = NewMockDataService(items: items2)
        let dataservice3 = NewMockDataService(items: items3)
        // then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataservice2.items.isEmpty)
        XCTAssertEqual(dataservice3.items.count, items3?.count)
    }
    
    func test_DataService_downloadItemsWithEscaping_doesReturnValues() {
        // given
        let dataService = NewMockDataService(items: [])
        
        // when
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithEscaping { ritems in
            items = ritems
            expectation.fulfill()
        }
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_DataService_downloadItemsWithCombine_doesReturnValues() {
        // given
        let dataService = NewMockDataService(items: [])
        
        // when
        var items: [String] = []
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail()
                }
            } receiveValue: { ritems in
                items = ritems
            }
            .store(in: &cancellables)

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_DataService_downloadItemsWithAsync_doesReturnValues() async {
        // given
        let dataService = NewMockDataService(items: [])
        
        // when
        let expectation = XCTestExpectation()
        let returnedItems = await dataService.downloadItemsWithAsyncAwait()
        expectation.fulfill()

        // then
        await XCTWaiter().fulfillment(of: [expectation], timeout: 5)
        XCTAssertGreaterThan(returnedItems.count, 1)
    }
    
    func test_DataService_Inyecting() async {
        // given
        let items = ["1", "2", "3", "4"]
        let dataService = NewMockDataService(items: items)
        let vm = UnitTestingBootcampVM(isPremium: Bool.random(), dataService: dataService)
    }
}
