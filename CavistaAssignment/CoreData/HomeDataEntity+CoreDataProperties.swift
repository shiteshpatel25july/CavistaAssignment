//
//  HomeDataEntity+CoreDataProperties.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//
//

import Foundation
import CoreData


extension HomeDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HomeDataEntity> {
        return NSFetchRequest<HomeDataEntity>(entityName: "HomeDataEntity")
    }

    @NSManaged public var data: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String
    @NSManaged public var type: String

}

extension HomeDataEntity {
    func convertToHomeDataModel() -> HomeDataModel {
        return HomeDataModel(id: self.id, type: DataType(rawValue: self.type) ?? .other, date: self.date, data: self.data)
    }
}
