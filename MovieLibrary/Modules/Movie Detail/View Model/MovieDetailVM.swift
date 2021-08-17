//
//  MovieDetailVM.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import RxSwift
import RxCocoa

class MovieDetailVM : NSObject {
    
    var movieId: String = ""{
        didSet {
            loadData(movieId)
        }
    }
    
    private var disposeBag = DisposeBag()
    var items = PublishSubject<MovieModel?>()

    func loadData(_ movieId: String){
        APIService.request(apiRequest: APIRequest().getMovieDetail(id: movieId), codable: MovieModel.self)
        .asObservable().subscribe(
            onNext: { resp in
                self.items.onNext(resp)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
}
