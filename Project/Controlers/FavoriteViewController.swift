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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try? Realm()

        let objects = realm?.objects(TopItemObject.self)
        print("objects = \(objects)")
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
