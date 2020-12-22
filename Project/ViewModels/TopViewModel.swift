//
//  TopViewModel.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import RxSwift
import RxCocoa

class TopListViewModel {

    private let topRepository: TopRepo

    private(set) var topList: TopList?

    private let _isCompletedToFetch: BehaviorRelay<Bool> = .init(value: false)

    private var _isEnd: Bool = false

    private let _pageLimitCount: Int = 50

    private let _finalCountsDown: Int = 20

    private let bag: DisposeBag = .init()

    var isCompletedToFetch: Observable<Bool> {
        _isCompletedToFetch.asObservable()
    }
    
    let type: String
    let subType: String

    init(topRepository: TopRepo, type: String, page: Int, subType: String) {
        self.topRepository = topRepository
        self.type = type
        self.subType = subType
    }

    func loadData() -> Observable<Void> {
        self.topRepository
            .getTop(type: type, page: 1, subType: subType)
            .do(onNext: { [weak self] (topList) in
                guard let self = self else { return }
                self.topList = topList
                self._isCompletedToFetch.accept(true)
                if topList.top.count < self._pageLimitCount {
                    self._isEnd = true
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                print("get top list error \(error) for \(self.type) and \(self.subType)")
            })
            .catch({ (error) -> Observable<TopList> in
                return .error(error)
            })
            .map { _ in () }
    }

    var numberOfWorks: Int { topList?.top.count ?? 0 }

    func loadMore() -> Observable<TopList> {
        return topRepository.getTop(type: type, page: _pageLimitCount, subType: subType)
            .do(onNext: { [weak self] topList in
                guard let self = self else { return }
                if topList.top.count < self._pageLimitCount {
                    self._isEnd = true
                }
                self.topList?.top.append(contentsOf: topList.top)
                self._isCompletedToFetch.accept(true)
            })
    }

    func shouldLoadMoreNormalRanking(at currentItem: Int) -> Bool {
        if _isEnd { return false }
        return currentItem == (self.numberOfWorks - 1) - _finalCountsDown
    }
}
