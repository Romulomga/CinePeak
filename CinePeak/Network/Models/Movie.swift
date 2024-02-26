import Foundation

struct Movie: Codable, Hashable, Identifiable {
    let id: Int
    let originalLanguage: String
    let overview: String
    let releaseDate: Date?
    let title: String
    let voteAverage: Double
    let posterPath: URL?
    let backdropPath: URL?

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case overview
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        overview = try container.decode(String.self, forKey: .overview)
        title = try container.decode(String.self, forKey: .title)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        
        let releaseDateValue = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        
        if let releaseDateValue {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            releaseDate = formatter.date(from: releaseDateValue)
        } else {
            releaseDate = nil
        }
        
        let posterPathValue = try container.decodeIfPresent(String.self, forKey: .posterPath)
        if let posterPathValue {
            posterPath = URL(string: "\(Environment.posterBasePath)\(posterPathValue)")
        } else {
            posterPath = nil
        }
        
        let backdropPathValue = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        if let backdropPathValue {
            backdropPath = URL(string: "\(Environment.backdropBasePath)\(backdropPathValue)")
        } else {
            backdropPath = nil
        }
    }
    
    func formatterYear() -> String? {
        guard let releaseDate else {
            return nil
        }
        let calendar = Calendar.current
        let yearComponent = calendar.component(.year, from: releaseDate)
        return String(format: "%d", yearComponent)
    }
}

extension Movie {
    init(id: Int, originalLanguage: String, overview: String, releaseDate: Date? = nil, title: String, voteAverage: Double, posterPath: URL? = nil, backdropPath: URL? = nil) {
        self.id = id
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}
