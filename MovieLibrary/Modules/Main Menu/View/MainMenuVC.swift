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

class MainMenuVC: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var tableView : UITableView = {
       var tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var searchBar: UISearchBar = UISearchBar()
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
        view.backgroundColor = .systemPurple
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
            //.debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                self.viewModel.keyword = query
            })
            .disposed(by: disposeBag)
    }
    
    func bindTableData(){
        
        //bind item to table
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, item, cell in
            cell.textLabel?.text = "Testing"
            cell.imageView?.image = UIImage(systemName: "")
        }.disposed(by: disposeBag)
        
        //bind a model selected handler
        tableView.rx.modelSelected(MovieModel.self).bind { model in
           let vc = MovieDetailVC()
           self.navigationController?.pushViewController(vc, animated: true)
        }

        //fetch item
        viewModel.loadData()
    }
    
}
