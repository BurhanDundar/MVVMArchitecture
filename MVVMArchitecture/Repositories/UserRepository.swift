import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

// Repository Pattern
final class UserRepository: UserRepositoryProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkManager.fetch("/users") { (result: Result<[User], NetworkError>) in
            completion(result)
        }
    }
} 
