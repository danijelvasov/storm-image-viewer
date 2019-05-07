//
//  ViewController.swift
//  Project1 - storm viewer
//
//  Created by Danijel Vasov on 4/10/19.
//  Copyright © 2019 OSX. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var count = [String : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let defaults = UserDefaults.standard
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! //iOS main bundle always has resourcePath, so !
        let items = try! fm.contentsOfDirectory(atPath: path) //also ! safe here because if cannot read main bundle, app is fundamentally broken and not usable
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                
            }
        }
        
        //load count data:
        if let savedCount = defaults.object(forKey: "count") as? [String : Int]  {
            count = savedCount
        }
        
       
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let sortedImages: [String] = pictures.sorted()
        cell.textLabel?.text = sortedImages[indexPath.row]
        return cell
        
    }

    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let sortedImages: [String] = pictures.sorted()    //to sort the list
            let indexOfImage = sortedImages.index(after: indexPath.row) //get the image position
            let imagesCount = sortedImages.count //count of all images
            let chosenImage = sortedImages[indexPath.row]
            
            if let currentCount = count[chosenImage] {
                count[chosenImage] = currentCount + 1
                } else {
                    count[chosenImage] = 1
            }
            
            let defaults = UserDefaults.standard
            defaults.set(count, forKey: "count")
            
            vc.selectedImage = chosenImage
            vc.currentIndex = indexOfImage
            vc.imagesCount = imagesCount
            vc.viewCount = count[chosenImage]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    
    @objc func shareTapped(){
        let store = "https://www.store.apple.com"
        let recommend: [Any] = ["Hi, check this Storm Viewer app @AppStore!", URL(string: store)!]
        
        let vc = UIActivityViewController(activityItems: recommend, applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    
    
}


