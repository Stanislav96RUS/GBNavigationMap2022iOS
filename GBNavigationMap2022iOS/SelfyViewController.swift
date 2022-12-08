//
//  SelfyViewController.swift
//  GBNavigationMap2022iOS
//
//  Created by Stanislav on 08.12.2022.
//

import UIKit


class SelfyViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
}
