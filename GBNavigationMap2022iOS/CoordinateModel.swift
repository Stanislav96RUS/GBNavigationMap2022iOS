//
//  CoordinateModel.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 23.11.2022.
//

import RealmSwift
import GoogleMaps

class CoordinateModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var latitude: Double = 0.00
    @objc dynamic var longitude: Double = 0.00
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(data: CLLocationCoordinate2D) {
        self.init()
        
        self.latitude = data.latitude
        self.longitude = data.longitude
    }
    
}
