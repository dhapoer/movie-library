//
//  MovieDetailVC.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MovieDetailVC: UIViewController {
    
    private var viewModel = MovieDetailVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupConstraint()
        setupEvent()
        bindTableData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ///TODO: load data
        
    }
    
    func setupUI(){
        title = "Movie Detail"
        view.backgroundColor = .systemPurple
    }
    
    func setupConstraint(){
    }
    
    func setupEvent(){

    }
    
    func bindTableData(){
        
    }
    
}

