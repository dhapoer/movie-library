//
//  MainMenuVC.swift
//  MovieLibrary
//
//  Created by abimanyu on 13/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

class MainMenuVC: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var tableView : UITableView = {
       var tableView = UITableView()
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for movies"
        return searchBar
    }()
    private var viewModel = MainMenuVM()

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
        title = "Movie Library"
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.backgroundColor = .systemGray
    }
    
    func setupConstraint(){
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupEvent(){
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.viewModel.keyword = (query == "" ? nil : query)
            })
            .disposed(by: disposeBag)
    }
    
    func bindTableData(){
        
        //bind item to table
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SearchMovieCell.self)) { row, item, cell in
            cell.bindData(item: item)
        }.disposed(by: disposeBag)
        
        //bind a model selected handler
        tableView.rx.modelSelected(SearchDetail.self).bind { item in
           let vc = MovieDetailVC(movieId: item.imdbID)
           self.navigationController?.pushViewController(vc, animated: true)
        }

        //fetch item
        viewModel.loadData()
    }
    
}
