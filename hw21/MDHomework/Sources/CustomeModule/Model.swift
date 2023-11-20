struct CharacterDataWrapper: Decodable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    var offset, limit, total, count: Int?
    var results: [Character]?
}

// MARK: - Result
struct Character: Decodable {
    var id: Int?
    var name, description: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    var comics: Comics?
    var series: Comics?
    var stories: Stories?
    var events: Comics?
    var urls: [URLElement]?
}

// MARK: - Comics
struct Comics: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [ComicsItem]?
    var returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Decodable {
    var resourceURI: String?
    var name: String?
}

// MARK: - Stories
struct Stories: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [StoriesItem]?
    var returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Decodable {
    var resourceURI: String?
    var name: String?
    var type: String? //MARK: вот тут ебала мозги
}

enum TypeEnum: String, Decodable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    var path: String
    var thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Decodable {
    var type: String?
    var url: String?
}
