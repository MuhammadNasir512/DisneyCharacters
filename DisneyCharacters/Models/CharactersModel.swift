import Foundation

struct RootObject: Codable {
    let data: [CharactersModel]
    let totalPages: Int
    let nextPage: String
}

struct CharactersModel: Codable {
    let id: Int
    let name: String?
    let films: [String]?
    let tvShows: [String]?
    let videoGames: [String]?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, films, tvShows, videoGames, imageUrl
    }
}
