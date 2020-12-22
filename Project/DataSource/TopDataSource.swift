//
//  TopDataSource.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import RxSwift

protocol TopDataSource {
    func getTop(type: String, page: Int, subType: String) -> Observable<Void>
}
