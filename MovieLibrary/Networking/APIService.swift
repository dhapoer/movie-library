//
//  APIService.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import Foundation
import RxSwift
import RxCocoa

public enum RequestType: String {
    case GET, POST, PUT,DELETE
}

class APIRequest {
    
    private let apiKey = "bd51cf64"
    private let urlBase = "https://www.omdbapi.com/"
    
    func getInitialData() -> URLRequest {
        let url = URL(string: "\(urlBase)?s=Batman&apikey=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.GET.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func searchMovieByName(search: String) -> URLRequest {
        let url = URL(string: "\(urlBase)?s=\(search)&apikey=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.GET.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func getMovieDetail(id: String) -> URLRequest {
        let url = URL(string: "\(urlBase)?i=\(id)&apikey=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.GET.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}


class APIService {
    // create a method for calling api which is return a Observable
    static func request<T: Codable>(apiRequest: URLRequest, codable: T.Type) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = URLSession.shared.dataTask(with: apiRequest) { (data, response, error) in
                do {
                    let model = try JSONDecoder().decode(codable, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
 
/*
class APIService  {
    

    private var disposeBag = DisposeBag()
    
    func getInitialData(success: @escaping([MovieModel]) -> (), failure: @escaping (Error) -> ()) {
        guard let url = URL(string: "\(urlBase)?s=Batman&apikey=\(apiKey)") else { return }

        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let resp):
                if let decodedResponse = try? JSONDecoder().decode([MovieModel].self, from: resp) {
                    success(decodedResponse)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func searchMovieByName(search: String, success: @escaping([MovieModel]) -> (), failure: @escaping (Error) -> ()) {
        guard let url = URL(string: "\(urlBase)?s=\(search)&apikey=\(apiKey)") else { return }

        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let resp):
                if let decodedResponse = try? JSONDecoder().decode([MovieModel].self, from: resp) {
                    success(decodedResponse)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getMovieDetail(id: String, success: @escaping(MovieModel) -> (), failure: @escaping (Error) -> ()){
        guard let url = URL(string: "\(urlBase)?i=\(id)&apikey=\(apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let resp):
                if let decodedResponse = try? JSONDecoder().decode(MovieModel.self, from: resp) {
                    success(decodedResponse)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
}
*/
