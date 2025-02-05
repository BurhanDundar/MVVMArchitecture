import XCTest
@testable import MVVMArchitecture

final class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    var mockRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        sut = UserListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func test_fetchUsers_shouldUpdateUsers() {
        // Given
        let expectation = expectation(description: "Fetch users")
        var didCallUsersDidChange = false
        
        sut.usersDidChange = {
            didCallUsersDidChange = true
            expectation.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(didCallUsersDidChange)
        XCTAssertEqual(sut.numberOfUsers, 1)
        XCTAssertEqual(sut.user(at: 0).name, "Test User")
    }
    
    func test_fetchUsers_whenError_shouldNotUpdateUsers() {
        // Given
        let expectation = expectation(description: "Fetch users error")
        mockRepository.shouldReturnError = true
        
        sut.usersDidChange = {
            expectation.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Then
        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.numberOfUsers, 0)
    }
    
    func test_numberOfUsers_shouldReturnCorrectCount() {
        // Given
        let expectation = expectation(description: "Number of users")
        
        sut.usersDidChange = {
            expectation.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(sut.numberOfUsers, 1)
    }
    
    func test_userAtIndex_shouldReturnCorrectUser() {
        // Given
        let expectation = expectation(description: "User at index")
        
        sut.usersDidChange = {
            expectation.fulfill()
        }
        
        // When
        sut.fetchUsers()
        
        // Then
        waitForExpectations(timeout: 1)
        let user = sut.user(at: 0)
        XCTAssertEqual(user.name, "Test User")
        XCTAssertEqual(user.email, "test@example.com")
    }
} 