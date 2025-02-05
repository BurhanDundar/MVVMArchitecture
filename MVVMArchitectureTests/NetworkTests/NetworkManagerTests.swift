import XCTest
@testable import MVVMArchitecture

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        sut = NetworkManager.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchUsers_shouldReturnUsers() {
        // Given
        let expectation = expectation(description: "Fetch users")
        var receivedUsers: [User]?
        var receivedError: NetworkError?
        
        // When
        sut.fetch("/users") { (result: Result<[User], NetworkError>) in
            switch result {
            case .success(let users):
                receivedUsers = users
            case .failure(let error):
                receivedError = error
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(receivedUsers)
        XCTAssertNil(receivedError)
        XCTAssertGreaterThan(receivedUsers?.count ?? 0, 0)
    }
    
    func test_fetchUsers_withInvalidURL_shouldReturnError() {
        // Given
        let expectation = expectation(description: "Fetch users with invalid URL")
        var receivedUsers: [User]?
        var receivedError: NetworkError?
        
        // When
        sut.fetch("/invalid-endpoint") { (result: Result<[User], NetworkError>) in
            switch result {
            case .success(let users):
                receivedUsers = users
            case .failure(let error):
                receivedError = error
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(receivedUsers)
        XCTAssertNotNil(receivedError)
    }
} 