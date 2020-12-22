//
//  DummyDataModel.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Foundation
@testable import Project

struct DummyDataModel {

    static let tempType = "anime"
    static let tempSubType = "upcoming"

    static let item = TopItem(
        malId: 41899,
        rank: 51,
        title: "Ore dake Haireru Kakushi Dungeon",
        url: "https://myanimelist.net/anime/41899/Ore_dake_Haireru_Kakushi_Dungeon",
        imageUrl: "https://cdn.myanimelist.net/images/anime/1266/109120.jpg?s=dbb07df01ab3d21a1c1a8f101093ee25",
        type: "TV",
        episodes: 1,
        startDate: "Jan 2021",
        endDate: "Jan 2021",
        members: 25806,
        score: 0
    )

    static let fakeTopList: TopList = TopList(
        requestHash: "request:top:4155a104dc132be741e194f184f5c664a6f8a898",
        requestCached: true,
        requestCacheExpiry: 53119,
        top: Array(repeating: item, count: 50)
    )
    
}
