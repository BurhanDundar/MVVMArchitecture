import Foundation
@testable import MVVMArchitecture

final class MockUserRepository {
    var shouldReturnError = false
    
    private let mockUsers = [
        User(id: 1, 
             name: "Test User", 
             username: "testuser",
             email: "test@example.com", 
             phone: "1-234-567-8900",
             website: "test.com",
             address: Address(street: "Test St", 
                            suite: "1", 
                            city: "Test City", 
                            zipcode: "12345",
                            geo: Geo(lat: "0", lng: "0")),
                            company: Company(name: "Test Co", 
                            catchPhrase: "Testing", 
                            bs: "test"))
    ]
}

extension MockUserRepository: UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        DispatchQueue.main.async {
            if self.shouldReturnError {
                completion(.failure(.noData))
            } else {
                completion(.success(self.mockUsers))
            }
        }
    }
} 
