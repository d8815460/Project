//
//  TopService.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Alamofire

enum TopService {
    case getTop(type: String, page: Int?, subType: String?)
}

extension TopService: WebService {

    var path: String {
        switch self {
        case .getTop(let type, let page, let subType):
            guard let subType = subType else {
                return "/v3/top/\(type)/\(page ?? 1)"
            }
            return "/v3/top/\(type)/\(page ?? 1)/\(subType)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTop: return .get
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getTop:
            return HTTPHeaders([])
        }
    }

//    var parameters: Parameters? {
//        switch self {
//        case .getTop(let type, let page, let subType):
//            var parameters = ["type": type]
//            if let page = page {
//                parameters["page"] = String(page)
//            }
//            if let subType = subType {
//                parameters["subType"] = subType
//            }
//            return parameters
//        }
//    }
}
