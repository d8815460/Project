//
//  Top.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Foundation

struct TopList {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    var top: [TopItem]
}

extension TopList: Decodable {
    enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case top = "top"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestHash = try container.decode(String.self, forKey: .requestHash)
        self.requestCached = try container.decode(Bool.self, forKey: .requestCached)
        self.requestCacheExpiry = try container.decode(Int.self, forKey: .requestCacheExpiry)
        self.top = try container.decode([TopItem].self, forKey: .top)
    }
}
extension TopList: Equatable { }

struct TopItem {
    let malId: Int
    let rank: Int
    let title: String
    let url: String
    let imageUrl: String
    let type: String
    let episodes: Int?
    let startDate: String?
    let endDate: String?
    let members: Int
    let score: Int
}

extension TopItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case rank
        case title
        case url
        case imageUrl = "image_url"
        case type
        case episodes
        case startDate = "start_date"
        case endDate = "end_date"
        case members
        case score
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.malId = try container.decode(Int.self, forKey: .malId)
        self.rank = try container.decode(Int.self, forKey: .rank)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.type = try container.decode(String.self, forKey: .type)
        self.episodes = try container.decode(Int?.self, forKey: .episodes)
        self.startDate = try container.decode(String?.self, forKey: .startDate)
        self.endDate = try container.decode(String?.self, forKey: .endDate)
        self.members = try container.decode(Int.self, forKey: .members)
        self.score = try container.decode(Int.self, forKey: .score)
    }
}

extension TopItem: Equatable { }
