//
//  TopRepository.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import RxSwift

protocol TopRepo {
    func getTop(type: String, page: Int?, subType: String?) -> Observable<TopList>
}

class TopRepository {
    private let dataSource: TopRemoteDataSource

    init(dataSource: TopRemoteDataSource) {
        self.dataSource = dataSource
    }
}

extension TopRepository: TopRepo {
    func getTop(type: String, page: Int?, subType: String?) -> Observable<TopList> {
        dataSource.getTop(type: type, page: page, subType: subType)
    }
}
