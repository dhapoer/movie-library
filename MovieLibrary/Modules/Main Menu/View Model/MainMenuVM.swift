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
    var isLoading = PublishSubject<Bool>()
    var keyword: String? = nil {
        didSet {
            disposeBag = DisposeBag()
            loadData(keyword)
        }
    }
    
    func loadData(_ search: String? = nil){
        if let query = search {
            self.isLoading.onNext(true)
            APIService.request(apiRequest: APIRequest().searchMovieByName(search: query), codable: SearchModel.self).asObservable().subscribe(
                onNext: { resp in
                    self.isLoading.onNext(false)
                    self.items.onNext(resp.search)
            }, onError: { error in
                self.isLoading.onNext(false)
                print(error)
            }).disposed(by: disposeBag)
        } else {
            self.isLoading.onNext(true)
            APIService.request(apiRequest: APIRequest().getInitialData(), codable: SearchModel.self).asObservable().subscribe(
                onNext: { resp in
                    self.isLoading.onNext(false)
                    self.items.onNext(resp.search)
            }, onError: { error in
                self.isLoading.onNext(false)
                print(error)
            }).disposed(by: disposeBag)
        }

    }
}
