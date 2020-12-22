//
//  TopRepositoryTests.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import XCTest
import RxSwift
@testable import Project

class TopRepositoryTests: XCTestCase {

    let repository: TopRepository = TopRepository(
        dataSource: MockTopDataSource()
    )

    private let bag: DisposeBag = .init()

    func testGetTop() {
        let exp = expectation(description: "Get Top List from repository")
        repository.getTop(type: "", page: 1, subType: "")
            .subscribe(onNext: { (topList) in
                XCTAssertNotNil(topList)
                exp.fulfill()
            })
            .disposed(by: bag)
        wait(for: [exp], timeout: 3)
    }

}
