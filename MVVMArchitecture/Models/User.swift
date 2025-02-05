import Foundation

// Given JSON guarantee that this variables are exists
// If some variables exist and some not, then we should use question mark after data type
// Example:
// let tckn: String?
// On the other hand, we can't load data to the tableView

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
