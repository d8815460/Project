//
//  FavoriteViewModel.swift
//  Project
//
//  Created by Ayi on 2020/12/24.
//
import RealmSwift
import RxSwift

class FavoriteViewModel {
    private var objects: Results<TopItemObject>?
    private var returnArray: [TopCellViewModel] = []

    var itemsCount: Int {
        return objects?.count ?? 0
    }

    func loadData() -> Observable<[TopCellViewModel]> {
        let realm = try? Realm()
        objects = realm?.objects(TopItemObject.self).filter("isFavorite = 1")
        guard let objects = objects else { return Observable.just([]) }
        for object in objects {
            let model = TopItem(
                malId: object.malId,
                rank: object.rank,
                title: object.title,
                url: object.url,
                imageUrl: object.imageUrl,
                type: object.type,
                episodes: object.episodes,
                startDate: object.startDate,
                endDate: object.endDate,
                members: object.members,
                score: object.score,
                isFavorite: object.isFavorite
            )
            returnArray.append(TopCellViewModel(model))
        }
        return Observable.just(returnArray)
    }
}
