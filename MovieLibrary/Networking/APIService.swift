//
//  APIService.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import Foundation

class APIService :  NSObject {
    
    private let apiKey = "bd51cf64"
    private let urlBase = "http://www.omdbapi.com/" //?i=tt3896198&apikey=

    func getMovieData(string: String?, completion : @escaping ([MovieModel]?) -> ()){
        /*
        URLSession.shared.dataTask(with: urlBase) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let empData = try! jsonDecoder.decode(Employees.self, from: data)
                    completion(empData)
            }
            
        }.resume()
        */
    }
    
}

