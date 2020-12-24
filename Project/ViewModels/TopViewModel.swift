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

    private var _currentPage: Int = 1

    private let bag: DisposeBag = .init()

    private var subViewModels: [TopCellViewModel] = []

    var isCompletedToFetch: Observable<Bool> {
        _isCompletedToFetch.asObservable()
    }

    var tops: [TopItem]? {
        return topList?.top
    }

    let type: String
    let subType: String

    init(topRepository: TopRepo, type: String, page: Int, subType: String) {
        self.topRepository = topRepository
        self.type = type
        self.subType = subType
    }

    func loadData() -> Observable<TopList> {
        self.topRepository.getTop(type: type, page: _currentPage, subType: subType)
            .do(onNext: { [weak self] topList in
                guard let self = self else { return }
                self.topList = topList
                self._isCompletedToFetch.accept(true)
            })
    }

    var numberOfWorks: Int { topList?.top.count ?? 0 }

    func loadMore() -> Observable<TopList> {
        _currentPage += 1
        return topRepository.getTop(type: type, page: _currentPage, subType: subType)
            .do(onNext: { [weak self] topList in
                guard let self = self else { return }
                if topList.top.count < self._pageLimitCount {
                    self._isEnd = true
                }
                self.topList?.top.append(contentsOf: topList.top)
                for topItem in topList.top {
                    self.subViewModels.append(TopCellViewModel(topItem))
                }
                self._isCompletedToFetch.accept(true)
            })
    }

    func shouldLoadMoreTopList(at currentItem: Int) -> Bool {
        if _isEnd { return false }
        return currentItem == (self.numberOfWorks - 1) - _finalCountsDown
    }

    func cellViewModel(at indexPath: IndexPath) -> TopCellViewModel {
        return self.subViewModels[indexPath.item]
    }
}
