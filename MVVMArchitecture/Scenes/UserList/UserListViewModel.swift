import Foundation

final class UserListViewModel {
    private var users: [User] = []
    private let repository: UserRepositoryProtocol
    
    // Callback Method tells to the UserListViewController that users are loaded
    var usersDidChange: (() -> Void)?
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    func fetchUsers() {
        repository.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.usersDidChange?()
            case .failure(let error):
                print("Error fetching users: \(error)")
                self?.usersDidChange?()
            }
        }
    }
} 
