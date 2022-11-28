//
//  Coordinator.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 27.11.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigation: UINavigationController { get set }
    func start()
    
}
