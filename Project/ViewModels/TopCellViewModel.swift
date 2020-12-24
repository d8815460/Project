//
//  TopCellViewModel.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

enum FavoriteState {
  case like
  case unlike
}

struct TopCellViewModel {
    private let _model: TopItem
    private var _isFavorite: Bool
    private let _favoriteState: BehaviorRelay<FavoriteState> = .init(value: .unlike)
    private var topItemObject: TopItemObject?

    init(_ model: TopItem) {
        self._model = model
        let realm = try? Realm()
        if let topItem = realm?.objects(TopItemObject.self).filter("malId = \(model.malId)").first {
            topItemObject = topItem
        }
        self._isFavorite = _model.isFavorite ?? false
        if self._isFavorite {
            self._favoriteState.accept(.like)
        } else {
            self._favoriteState.accept(.unlike)
        }
    }

    var favoriteState: Observable<FavoriteState> {
        return _favoriteState.asObservable()
    }

    var malId: Int { _model.malId }

    var rank: Int { _model.rank }

    var title: String { _model.title }

    var url: String { _model.url }

    var imageUrl: String { _model.imageUrl }

    var type: String { _model.type }

    var episodes: Int? { _model.episodes }

    var startDate: String? { _model.startDate }

    var endDate: String? { _model.endDate }

    var members: Int { _model.members }

    var score: Int { _model.score }

    var isFavorite: Bool? { _model.isFavorite }

    mutating func toggleFavoriteButton() {
        self._isFavorite.toggle()
        if self._isFavorite {
            self._favoriteState.accept(.like)
        } else {
            self._favoriteState.accept(.unlike)
        }
        self.saveToLocalDB()
    }

    mutating func saveToLocalDB() {
        let realm = try? Realm()
        if let topItemObject = topItemObject {
            try! realm?.write {
                topItemObject.isFavorite = self._isFavorite
            }
        } else {
            let topItemObject = TopItemObject()
            topItemObject.malId = _model.malId
            topItemObject.rank = _model.rank
            topItemObject.title = _model.title
            topItemObject.url = _model.url
            topItemObject.imageUrl = _model.imageUrl
            topItemObject.type = _model.type
            topItemObject.episodes = _model.episodes
            topItemObject.startDate = _model.startDate
            topItemObject.endDate = _model.endDate
            topItemObject.members = _model.members
            topItemObject.score = _model.score
            topItemObject.isFavorite = self._isFavorite
            try! realm?.write {
                realm?.add(topItemObject)
            }
        }
    }
}
    
