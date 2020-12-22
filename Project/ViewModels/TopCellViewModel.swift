//
//  TopCellViewModel.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import UIKit

struct TopCellViewModel {
    private let _model: TopItem

    init(_ model: TopItem) {
        self._model = model
    }

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
}
    
