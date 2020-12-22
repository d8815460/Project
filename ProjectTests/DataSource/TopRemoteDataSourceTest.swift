//
//  TopRemoteDataSourceTest.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import XCTest
import RxSwift
@testable import Project

class TopRemoteDataSourceTest: XCTestCase {

    let dataSource: TopRemoteDataSource = .init()
    let bag: DisposeBag = .init()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        RequestInterceptor.deactivate()
        super.tearDown()
    }

    func testGetTopList() {
        RequestInterceptor.activate(router: .getTopList)
        let exp = expectation(description: "Get top list from data source")
        dataSource.getTop(type: "", page: 1, subType: "")
            .subscribe(onNext: { topList in
                XCTAssertEqual(topList, DummyDataModel.fakeTopList)
                exp.fulfill()
            })
            .disposed(by: bag)
        wait(for: [exp], timeout: 3)
    }

}
