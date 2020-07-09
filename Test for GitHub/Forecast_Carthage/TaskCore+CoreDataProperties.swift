//
//  TaskCore+CoreDataProperties.swift
//  Forecast
//
//  Created by Berezkin on 09.07.2020.
//  Copyright © 2020 Berezkin. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCore> {
        return NSFetchRequest<TaskCore>(entityName: "TaskCore")
    }

    @NSManaged public var task: String?
    @NSManaged public var id: Int16

}
