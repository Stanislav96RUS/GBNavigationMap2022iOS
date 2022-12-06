//
//  LocationManagerService.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 30.11.2022.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

final class LocationManagerService: NSObject {
    // MARK: Properties
    static let instance = LocationManagerService()
    
    let locationManager = CLLocationManager()
    let location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    
    private override init() {
        super.init()
    }
}
