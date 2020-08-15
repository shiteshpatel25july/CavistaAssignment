//
//  HomeDataViewModel.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import Foundation
import Alamofire

class HomeDataListViewModel {
    private var homeListViewModel: [HomeDataModel]?
    private let serviceManager = WebServiceManager()

    func loadData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        
        if NetworkReachabilityManager.default?.isReachable ?? false {
            //Load live data from server
            loadLiveData { (success) in
                completionHandler(success)
            }
        } else {
            //Load local saved data
            loadSavedData { (success) in
                completionHandler(success)
            }
        }
    }
    
    private func loadLiveData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        serviceManager.loadData(endpoint: Constants.HomeDataSourceURL, resultType: [HomeDataModel].self) { [weak self] (response) in

            //Check data did get or not
            if let listData = response {
                // Save data in coredata in background thread
                self?.saveDataIntoCoreData(data: listData)
                
                self?.homeListViewModel = listData
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

    private func saveDataIntoCoreData(data: [HomeDataModel]?) {
        if let dataModelList = data {
            let backgroundQueue = DispatchQueue.global(qos: .background)
            backgroundQueue.async {
                HomeDataRepository().saveHomeDataEntity(listData: dataModelList)
            }
        }
    }
    
    private func loadSavedData(completionHandler: @escaping (_ isSuccess: Bool) -> Void) {
        if let listData = HomeDataRepository().getAll() {
            self.homeListViewModel = listData
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}


extension HomeDataListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.homeListViewModel?.count ?? 0
    }
    
    func homeListDataAtIndex(_ index: Int) -> HomeDataViewModel? {
        if index >= self.homeListViewModel?.count ?? 0 {
            return nil
        }

        guard let homeData = self.homeListViewModel?[index] else {
            return nil
        }
        return HomeDataViewModel(homeData)
    }
    
    func homeDataModelAtIndex(_ index: Int) -> HomeDataModel? {
        if index >= self.homeListViewModel?.count ?? 0 {
            return nil
        }

        guard let homeData = self.homeListViewModel?[index] else {
            return nil
        }
        return homeData
    }
}


struct HomeDataViewModel {
    private let homeData: HomeDataModel

    init(_ homeData: HomeDataModel) {
        self.homeData = homeData
    }
}


extension HomeDataViewModel {
    var id: String {
        return self.homeData.id
    }
    
    var type: DataType {
        return self.homeData.type
    }
    
    var date: String? {
        return self.homeData.date
    }
    
    var data: String? {
        return self.homeData.data
    }
}

