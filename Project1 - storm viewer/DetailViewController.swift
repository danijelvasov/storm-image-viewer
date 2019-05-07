//
//  DetailViewController.swift
//  Project1 - storm viewer
//
//  Created by Danijel Vasov on 4/10/19.
//  Copyright © 2019 OSX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imagesCount: Int?
    var currentIndex: Int?
    var viewCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imagesCount != nil && currentIndex != nil {
            title = "Pic \(currentIndex!)|\(imagesCount!)  (seen \(viewCount!) times)"
        }
        
        navigationItem.largeTitleDisplayMode = .never //do not use large title inherited from parent vc on THIS VC.
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }


}
