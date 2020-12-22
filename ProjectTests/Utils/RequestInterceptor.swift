//
//  RequestInterceptor.swift
//  ProjectTests
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Foundation
import OHHTTPStubs
@testable import Project
struct RequestInterceptor {
    
    enum Router {
        case getTopList
        var path: String {
            switch self {
            case .getTopList:
                return "/v3/top/\(DummyDataModel.tempType)/\(1)/\(DummyDataModel.tempSubType)"
            }
        }

        var filename: String {
            switch self {
            case .getTopList:
                return "getTopList"
            }
        }
    }

    static let host: String = "api.jikan.moe"

    static func activate(router: Router) {
        switch router {
        case .getTopList:
            stub(condition: isHost(host)) { (_) -> HTTPStubsResponse in
                let responseData = DataProvider.jsonData(from: router.filename)
                return HTTPStubsResponse(data: responseData ?? Data(), statusCode: 200, headers: nil)
            }
        }
    }

    static func deactivate() {
        HTTPStubs.removeAllStubs()
    }
}
