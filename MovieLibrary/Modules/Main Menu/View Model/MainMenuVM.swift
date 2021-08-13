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
    
    var items = PublishSubject<[MovieModel]>()
    var keyword: String? = nil {
        didSet {
            loadData(keyword)
        }
    }
    
    func loadData(_ search: String? = nil){
        
    }
}
