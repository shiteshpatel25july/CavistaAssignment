//
//  HomeListViewController.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import UIKit
import SnapKit

class HomeListViewController: UIViewController {
    private let imageCellIdentifier = "imagecell"
    private let textCellIdentifier = "textcell"
    
    private let tableView = UITableView()

    private let homeDataListViewModel = HomeDataListViewModel()
    
    override func loadView() {
        super.loadView()

        //Setup navigation view
        setUpNavigation()
        
        //setup table view
        setupTableView()        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Register tableview cells
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: imageCellIdentifier)
        tableView.register(TextTableViewCell.self, forCellReuseIdentifier: textCellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        //get list data
        getListData()
    }
    
    //Setup navigation view
    func setUpNavigation() {
        navigationItem.title = "Home List"
        
    }

    //Add tableview on view and set constraints
    func setupTableView() {
        view.addSubview(tableView)

        // Add tableview constraints
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    //ask viewmodel for list data
    private func getListData() {
        homeDataListViewModel.loadData { [weak self] (success) in
            if success {
                self?.reloadView()
            }
        }
    }

    //reload view after getting list data
    private func reloadView() {
        DispatchQueue.main.async {
            //reload table view
            self.tableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeDataListViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.homeDataListViewModel.homeListDataAtIndex(indexPath.row)
        
        if cellData?.type == DataType.image {
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier) as! ImageTableViewCell
            cell.dataViewModel = cellData
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as! TextTableViewCell
            cell.dataViewModel = cellData
            return cell
        }
    }
}

extension HomeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        if let data = self.homeDataListViewModel.homeDataModelAtIndex(indexPath.row) {
            detailVC.detailDataViewModel = HomeDataDetailViewModel(data)
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
