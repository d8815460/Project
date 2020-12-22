//
//  ApiManager.swift
//  Project
//
//  Created by 陳駿逸 on 2020/12/22.
//

import Alamofire
import RxSwift

final class ApiManager {
    static let shared = ApiManager()
    static var alamofireManager: Session! = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let alamofireManager = Session(configuration: configuration)
        return alamofireManager
    }()

    private let bag = DisposeBag()


    // swiftlint:disable function_body_length
    func request(_ service: WebService) -> Observable<Data> {
        var urlComponent = URLComponents(string: service.baseUrl)!
        urlComponent.path = service.path
        urlComponent.queryItems = service.queryItems
        let headers = service.headers

        URLCache.shared.removeAllCachedResponses()

        return Observable<Data>.create { [urlComponent] observer -> Disposable in
            let request = ApiManager.alamofireManager.request(
                urlComponent,
                method: service.method,
                parameters: service.parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            request.responseData { afResponse in
                var responseStatusCode: Int = 0
                if let statusCode = afResponse.response?.statusCode {
                    print("[Res] Router = \(type(of: service)); Url = \(urlComponent); Status Code = \(statusCode)")
                    responseStatusCode = statusCode
                } else {
                    print("[Res] Router = \(type(of: service)); Url = \(urlComponent); response is missing")
                }

                switch afResponse.result {
                case .success(let data):
                    switch responseStatusCode {
                    case 200...299:
                        observer.onNext(data)
                        observer.onCompleted()
                    default: break
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create { request.cancel() }
        }
        .catch { (error) -> Observable<Data> in
            return .error(error)
        }
    }
}
