//
//  TopRemoteDataSource.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import RxSwift

class TopRemoteDataSource: TopDataSource {
    func getTop(type: String, page: Int?, subType: String?) -> Observable<TopList> {
        return ApiManager.shared.request(
            TopService.getTop(
                type: type,
                page: page,
                subType: subType
            )
        ).map { try JSONDecoder().decode(TopList.self, from: $0) }
    }
}
