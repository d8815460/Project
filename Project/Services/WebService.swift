//
//  WebService.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Foundation
import Alamofire

protocol WebService {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: Parameters? { get }
}

extension WebService {
    var baseUrl: String { "https://api.jikan.moe" }
    var queryItems: [URLQueryItem]? { nil }
    var parameters: Parameters? { nil }
}
