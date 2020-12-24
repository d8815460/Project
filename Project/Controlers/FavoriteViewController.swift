//
//  FavoriteViewController.swift
//  Project
//
//  Created by Ayi on 2020/12/24.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var objects: Results<TopItemObject>?
    private var cellHeight: CGFloat = 180
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try? Realm()

        objects = realm?.objects(TopItemObject.self).filter("isFavorite = 1")
        tableView.reloadData()
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
        return objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.reuseId, for: indexPath) as? TopCell,
            let objects = objects
        else { return UITableViewCell() }
        let model = TopItem(
            malId: objects[indexPath.item].malId,
            rank: objects[indexPath.item].rank,
            title: objects[indexPath.item].title,
            url: objects[indexPath.item].url,
            imageUrl: objects[indexPath.item].imageUrl,
            type: objects[indexPath.item].type,
            episodes: objects[indexPath.item].episodes,
            startDate: objects[indexPath.item].startDate,
            endDate: objects[indexPath.item].endDate,
            members: objects[indexPath.item].members,
            score: objects[indexPath.item].score,
            isFavorite: objects[indexPath.item].isFavorite
        )
        let subViewModel = TopCellViewModel(model)
        cell.bind(subViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
