//
//  TopViewModelTests.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Project

class TopViewModelTests: XCTestCase {

    private let viewModel: TopListViewModel = .init(
        topRepository: TopRepository(
            dataSource: MockTopDataSource()
        ),
        type: "",
        page: 1,
        subType: ""
    )

    private let bag: DisposeBag = .init()

    func testGetLoadData() {
        let initial = expectation(description: "Initial value before get top list")
        let topListGot = expectation(description: "Get over all top list")
        viewModel.isCompletedToFetch
            .subscribe(onNext: { [weak self] isCompleted in
                if !isCompleted {
                    initial.fulfill()
                    return
                }
                XCTAssertEqual(
                    self?.viewModel.topList,
                    DummyDataModel.fakeTopList
                )
                topListGot.fulfill()
            })
            .disposed(by: bag)
        viewModel.loadData().subscribe().disposed(by: bag)
        wait(for: [initial, topListGot], timeout: 3, enforceOrder: true)
    }

    func testShouldLoadMoreTopList() {
        let initial = expectation(description: "Initial value before get top list")
        let topListGot = expectation(description: "Get top list")
        viewModel.isCompletedToFetch
            .subscribe(onNext: { [weak self] isCompleted in
                if !isCompleted {
                    initial.fulfill()
                    return
                }
                guard let self = self else { return }
                XCTAssertFalse(self.viewModel.shouldLoadMoreTopList(at: 28))
                XCTAssertTrue(self.viewModel.shouldLoadMoreTopList(at: 29))
                XCTAssertFalse(self.viewModel.shouldLoadMoreTopList(at: 30))
                topListGot.fulfill()
            })
            .disposed(by: bag)
        viewModel.loadData().subscribe().disposed(by: bag)
        wait(for: [initial, topListGot], timeout: 3)
    }
}
