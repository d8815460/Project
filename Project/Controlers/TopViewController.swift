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

    private var cellHeight: CGFloat = 180

    @IBOutlet weak var tableView: UITableView!

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
                    self.tableView.reloadData()
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
                self.tableView.reloadData()
            })
            .disposed(by: bag)
    }

    @IBAction func typeButtonPressed(_ sender: Any) {
    }
    
    @IBAction func subTypeButtonPressed(_ sender: Any) {
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let viewController = segue.destination as? DetailViewController
        viewController?.webUrl = sender as? String
    }
}

extension TopViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.reuseId, for: indexPath) as? TopCell,
            let topList = topList
        else { return UITableViewCell() }
        
        let subViewModel = TopCellViewModel(topList[indexPath.item])
        cell.bind(subViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let topList = topList else { return }
        let webUrl = topList[indexPath.item].url
        self.performSegue(withIdentifier: "webview", sender: webUrl)
    }
}
