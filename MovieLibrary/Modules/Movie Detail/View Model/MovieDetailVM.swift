//
//  MovieDetailVM.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import RxSwift
import RxCocoa

class MovieDetailVM : NSObject {
    
    var items = PublishSubject<MovieModel>()

    func loadData(_ id: String){
        
    }
}
