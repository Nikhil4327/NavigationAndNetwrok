//
//  NetworkingConceptsViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 23/06/22.
//

import UIKit

class Downloader {
    class func downloadImageFromURL(urlString : String) -> UIImage {
        let url = URL(string: urlString)!
        let data = NSData(contentsOf: url)
        return UIImage(data: data! as Data)!
    }
}




class NetworkingConceptsViewController: UIViewController {
    
    let urlArray = ["https://www.planetware.com/photos-large/CH/switzerland-matterhorn.jpg", "https://www.planetware.com/photos-large/CH/switzerland-lake-geneva-region.jpg", "https://www.planetware.com/photos-large/CH/switzerland-st-moritz.jpg", "https://www.planetware.com/photos-large/CH/switzerland-bern.jpg"]
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {

        let operation1 = BlockOperation {
            let extractedImage = Downloader.downloadImageFromURL(urlString: self.urlArray[0])
            OperationQueue.main.addOperation {
                self.imageView1.image = extractedImage
            }
        }
        let operation2 = BlockOperation {
            let extractedImage = Downloader.downloadImageFromURL(urlString: self.urlArray[1])
            OperationQueue.main.addOperation {
                self.imageView2.image = extractedImage
            }
        }
        let operation3 = BlockOperation {
            let extractedImage = Downloader.downloadImageFromURL(urlString: self.urlArray[2])
            OperationQueue.main.addOperation {
                self.imageView3.image = extractedImage
            }
        }
        let operation4 = BlockOperation {
            let extractedImage = Downloader.downloadImageFromURL(urlString: self.urlArray[3])
            OperationQueue.main.addOperation {
                self.imageView4.image = extractedImage
            }
        }
        
        operation4.addDependency(operation3)
        operation3.addDependency(operation2)
        operation2.addDependency(operation1)
        
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        queue.addOperation(operation4)
    }
}
