//
//  TopViewController.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit
import RxSwift

class TopViewController: UIViewController {

    private var viewModel: TopListViewModel?

    private let bag: DisposeBag = .init()

    private var topList: [TopItem]?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        fetchTop()
    }

    func fetchTop() {
        let dataSource = TopRemoteDataSource()
        let repository = TopRepository(dataSource: dataSource)
        viewModel = TopListViewModel(topRepository: repository, type: "anime", page: 1, subType: "upcoming")
        viewModel?.loadData()
            .subscribe(
                onNext: { [weak self] (topList) in
                    guard let self = self else { return }
                    self.topList = topList.top
                },
                onError: { (error) in
                    print("error: \(error)")
                }
            )
            .disposed(by: bag)
    }
    
    func setupRx() {
        viewModel?.isCompletedToFetch
            .subscribe(onNext: { (isCompletedToFetch) in
                // update UI
            })
            .disposed(by: bag)
    }

    @IBAction func typeButtonPressed(_ sender: Any) {
    }
    
    @IBAction func subTypeButtonPressed(_ sender: Any) {
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
    }
}
