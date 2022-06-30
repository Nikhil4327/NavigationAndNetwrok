//
//  AddUserViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 27/06/22.
//

import UIKit

protocol AddUserViewControllerDelegate : NSObjectProtocol {
    func userDidCancell(_ controller : AddUserViewController)
    func userDidAdded(_ controller : AddUserViewController, user : User)
}

class AddUserViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    weak var delegate : AddUserViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let user = User(id: 1, email: emailField.text!, first_name: nameField.text!, last_name: "NA", avatar: "https://reqres.in/img/faces/7-image.jpg")
        delegate?.userDidAdded(self, user: user)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.userDidCancell(self)
    }
}
