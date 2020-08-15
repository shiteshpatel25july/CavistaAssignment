//
//  HomeDataDetailViewModel.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 14/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import Foundation

struct HomeDataDetailViewModel {
    private let homeData: HomeDataModel

    init(_ homeData: HomeDataModel) {
        self.homeData = homeData
    }
}


extension HomeDataDetailViewModel {
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
