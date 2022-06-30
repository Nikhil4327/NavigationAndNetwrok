//
//  DetailsViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 27/06/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var largeLabel: UILabel!
    
    @IBOutlet weak var smallLabel: UILabel!
    
    var selectedUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewsWithUserData()
        
    }
    
    
    func updateViewsWithUserData() {
        guard let user = selectedUser  else { return }
        self.profileImageView.image = Downloader.downloadImageFromURL(urlString: user.avatar)
        self.largeLabel.text = user.first_name + " " + user.last_name
        self.smallLabel.text = user.email
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
