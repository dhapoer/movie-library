//
//  MainMenuVM.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import Foundation
import RxSwift
import RxCocoa

class MainMenuVM : NSObject {
    
    private var disposeBag = DisposeBag()
    
    var items = PublishSubject<[SearchDetail]>()
    var keyword: String? = nil {
        didSet {
            loadData(keyword)
        }
    }
    
    func loadData(_ search: String? = nil){
        if let query = search {
            APIService.request(apiRequest: APIRequest().searchMovieByName(search: query), codable: SearchModel.self).asObservable().subscribe(
                onNext: { resp in
                    self.items.onNext(resp.search)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        } else {
            APIService.request(apiRequest: APIRequest().getInitialData(), codable: SearchModel.self).asObservable().subscribe(
                onNext: { resp in
                    self.items.onNext(resp.search)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        }

    }
}
