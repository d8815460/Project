//
//  MockTopDataSource.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import XCTest
import RxSwift
@testable import Project

class MockTopDataSource: TopRemoteDataSource {
    override func getTop(type: String, page: Int?, subType: String?) -> Observable<TopList> {
        return Observable.just(DummyDataModel.fakeTopList)
    }
}
