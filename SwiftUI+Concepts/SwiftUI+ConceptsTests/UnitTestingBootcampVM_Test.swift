//
//  UnitTestingBootcampVM_Test.swift
//  SwiftUI+ConceptsTests
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

import XCTest
import Combine
@testable import SwiftUI_Concepts

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

// testing structure: Given, Then, When

final class UnitTestingBootcampVM_Test: XCTestCase {
    
    var viewModel: UnitTestingBootcampVM?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampVM(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

 
    func test_UnitTestingBootcampVM_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        // When 
        let vm = UnitTestingBootcampVM(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampVM_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        // When 
        let vm = UnitTestingBootcampVM(isPremium: userIsPremium)
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampVM_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        // When 
        let vm = UnitTestingBootcampVM(isPremium: userIsPremium)
        // Then
        XCTAssertEqual(userIsPremium, vm.isPremium)
    }
    
    func test_UnitTestingBootcampVM_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let userIsPremium: Bool = Bool.random()
            // When 
            let vm = UnitTestingBootcampVM(isPremium: userIsPremium)
            // Then
            XCTAssertEqual(userIsPremium, vm.isPremium)            
        }
    }
    
    func test_UnitTestingBootcampVM_dataArray_shouldBeEmpty() {
        // when 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampVM_dataArray_shouldAddItems() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        vm.addItem(item: "test")
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        //XCTAssertGreaterThanOrEqual(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        //XCTAssertLessThan(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        
    }
    
    func test_UnitTestingBootcampVM_dataArray_shouldAddItems_stress() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)            
        }
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingBootcampVM_dataArray_shouldNotAddItemsIfEmptyString() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
        XCTAssertLessThan(vm.dataArray.count, 1)
        //XCTAssertGreaterThanOrEqual(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        //XCTAssertLessThan(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        
    }
    
    func test_UnitTestingBootcampVM_dataArray_shouldNotAddItemsIfEmptyString2() {
        // given 
        guard let vm = viewModel else { 
            XCTFail()
            return 
        }
        // when
        vm.addItem(item: "")
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
        XCTAssertLessThan(vm.dataArray.count, 1)
        //XCTAssertGreaterThanOrEqual(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        //XCTAssertLessThan(<#T##expression1: Comparable##Comparable#>, <#T##expression2: Comparable##Comparable#>)
        
    }
    
    func test_UnitTestingBootcampVM_selectedItem_shouldStartsAtNil() {
        // given 
        // when
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampVM_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampVM_selectedItem_shouldBeSelected() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampVM_selectedItem_shouldBeSelected_stress() {
        // given 
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)    
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootcampVM_saveItem_shoulThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found") { error in
            let returnedError = error as? UnitTestingBootcampVM.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampVM.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampVM_saveItem_shoulThrowError_noData() {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch {
            let returnedError = error as? UnitTestingBootcampVM.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampVM.DataError.noData)
        }
    }
    
    func test_UnitTestingBootcampVM_saveItem_shoulThrowError_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)    
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        // this is another way to write test above
        do {
            try vm.saveItem(item: randomItem)
        } catch {
           XCTFail()
        }
    }
    
    func test_UnitTestingBootcampVM_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // when
        let expectation = XCTestExpectation(description: "should return items after 3 seconds")
        vm.downloadWithEscaping()
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation] , timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampVM_downloadWithCombine_shouldReturnItems() {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // when
        let expectation = XCTestExpectation(description: "should return items after a second")
        vm.downloadWithCombine()
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation] , timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampVM_downloadWithAsync_shouldReturnItems() async {
        // Given
        let vm = UnitTestingBootcampVM(isPremium: Bool.random())
        
        // when
        let expectation = XCTestExpectation(description: "should return items after 3 seconds")
        Task {
            await vm.downloadWithAsyncAwait()
            XCTAssertEqual(vm.dataArray, ["one", "two"])            
        }
        // Then
        await XCTWaiter().fulfillment(of: [expectation], timeout: 4)
    }
}
