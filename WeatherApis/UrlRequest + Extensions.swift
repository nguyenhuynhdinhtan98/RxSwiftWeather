//
//  UrlRequest + Extensions.swift
//  WeatherApis
//
//  Created by tantest on 30/08/2022.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct Resource<T> {
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable> (resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url]).flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { item -> T in
            return try JSONDecoder().decode(T.self, from: item)
        }.asObservable()
    }
}
