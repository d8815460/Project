//
//  FavoriteViewController.swift
//  Project
//
//  Created by Ayi on 2020/12/24.
//

import UIKit
import RealmSwift
import RxSwift

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = FavoriteViewModel()
    private var cellHeight: CGFloat = 180
    private let bag: DisposeBag = .init()
    private var objects: [TopCellViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
            .subscribe(onNext: { [weak self] subViewModels in
                guard let self = self else { return }
                self.objects = subViewModels
                self.tableView.reloadData()
            })
            .disposed(by: bag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.reuseId, for: indexPath) as? TopCell,
            let objects = objects
        else { return UITableViewCell() }
        cell.bind(objects[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
