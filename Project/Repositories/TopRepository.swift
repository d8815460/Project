//
//  TopRepository.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import RxSwift

protocol TopRepo {
    func getTop(type: String, page: Int, subType: String) -> Observable<Void>
}

class TopRepository {
    private let dataSource: TopDataSource

    init(dataSource: TopDataSource) {
        self.dataSource = dataSource
    }
}

extension TopRepository: TopRepo {
    func getTop(type: String, page: Int, subType: String) -> Observable<Void> {
        dataSource.getTop(type: type, page: page, subType: subType)
    }
}
