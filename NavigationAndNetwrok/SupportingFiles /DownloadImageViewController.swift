//
//  DownloadImageViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 23/06/22.
//

import UIKit

class DownloadImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        
        let imageURL = URL(string: "https://www.planetware.com/photos-large/CH/switzerland-matterhorn.jpg")!
        
        // show activity indicator
        
        URLSession.shared.downloadTask(with: imageURL) { (fileURL, urlResponse, error) in

            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            let response = urlResponse as! HTTPURLResponse
            
            guard response.statusCode == 200 else {
                print(response.statusCode)
                return
            }
            
            if let url = fileURL {
                let fileFromURL = NSData(contentsOf: url)
                print(url)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: fileFromURL! as Data)
                    self.imageView.image = image
                    
                }
            }
        }.resume()
    }
    
    
    
    
    
    
}
