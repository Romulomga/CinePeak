import Foundation

struct Movie: Codable {
    let id: Int
    let adult: Bool?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        
        let posterPathValue = try container.decodeIfPresent(String.self, forKey: .posterPath)
        if let posterPathValue {
            posterPath = "\(Environment.posterBasePath)\(posterPathValue)"
        } else {
            posterPath = nil
        }
        
        let backdropPathValue = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        if let backdropPathValue {
            backdropPath = "\(Environment.backdropBasePath)\(backdropPathValue)"
        } else {
            backdropPath = nil
        }
    }
}
