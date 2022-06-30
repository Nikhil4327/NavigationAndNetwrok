//
//  UsersTableViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 23/06/22.
//

import UIKit

class UsersTableViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    let userListUrl = URL(string: "https://reqres.in/api/users?page=2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.dataSource = self
        getUsers()
        
    }
    
    
    func getUsers() {
        var urlRequest = URLRequest(url: userListUrl!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard data != nil, error == nil else {print(error?.localizedDescription ?? "error");return}
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode == 200  else {print(httpResponse?.statusCode ?? "error");return}
            
            DispatchQueue.main.async {
                self.extractUserData(data: data!)
            }
        }.resume()
    }
    
    
    var userList = [User]()
    
    func extractUserData(data : Data) {
        guard let result = try? JSONDecoder().decode(UserResponse.self, from: data) else {return}
        userList = result.data
        usersTableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            let detailsViewController = segue.destination as! DetailsViewController
            let indexPath = usersTableView.indexPathForSelectedRow
            detailsViewController.selectedUser = userList[indexPath!.row]
            
        } else if segue.identifier == "AddUserSegue" {
            
            let addUserViewController = segue.destination as! AddUserViewController
            addUserViewController.delegate = self
        }
    }
}


extension UsersTableViewController : AddUserViewControllerDelegate {
    
    func userDidCancell(_ controller: AddUserViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func userDidAdded(_ controller: AddUserViewController, user: User) {
        userList.append(user)
        usersTableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}








extension UsersTableViewController : UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! UserTableViewCell
        
        let firstName = userList[indexPath.row].first_name
        let lastName = userList[indexPath.row].last_name
        
        cell.nameLabel.text = firstName + " " + lastName
        cell.emailLabel.text = userList[indexPath.row].email
        cell.profileImageView.image = Downloader.downloadImageFromURL(urlString: userList[indexPath.row].avatar)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
