//
//  ViewController.swift
//  NavigationAndNetwrok
//
//  Created by Tarun Sharma on 23/06/22.
//




import UIKit




class ViewController: UIViewController {
    
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var termsCheckButton: UIButton!
    
    @IBOutlet weak var termsDescriptionButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let emailPattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsCheckButton.layer.cornerRadius = 20
        termsCheckButton.layer.borderWidth = 1
        
        if UserDefaults.standard.value(forKey: "token") != nil {
            // navigate to homePage (userListPage)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 4) {
            self.appNameLabel.frame = CGRect(x: self.appNameLabel.frame.origin.x, y: self.appNameLabel.frame.origin.y - 30, width: self.appNameLabel.frame.width, height: self.appNameLabel.frame.height)
            self.appNameLabel.alpha = 1
        }
    }
    
    var termsIsChecked = false
    
    @IBAction func termsCheckButtonTapped(_ sender: UIButton) {
        
        termsIsChecked = !termsIsChecked
        
        switch termsIsChecked {
        case true:
            UIView.animate(withDuration: 0.2) {
                self.termsCheckButton.backgroundColor = UIColor.systemBlue
                self.loginButton.isEnabled = true
            }
        default:
            UIView.animate(withDuration: 0.2) {
                self.termsCheckButton.backgroundColor = UIColor.white
                self.loginButton.isEnabled = false
            }
        }
    }
    
    
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("The email or password cannot be empty")    // show alert function (extension)
            return
        }
        
        let evaluationResult = emailTextField.text?.range(of: emailPattern, options: String.CompareOptions.regularExpression, range: nil, locale: nil)
        
        if evaluationResult == nil {
            print("invalid email ") // show alert
            self.emailTextField.layer.borderWidth = 0.5
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        
        let loginURL = URL(string: "https://reqres.in/api/login")!
        var loginRequest = URLRequest(url: loginURL)
        let body = ["email" : emailTextField.text, "password" : passwordTextField.text]
        loginRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        loginRequest.httpMethod = "POST"
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            
            guard data != nil, error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            
            guard httpResponse?.statusCode == 200  else {
                print(httpResponse?.statusCode)
                return
            }
            
            let extractedData = try? (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : String])
            
            let token = extractedData!["token"]!
            
            DispatchQueue.main.async {
                self.navigate(token : token)
            }
            
        }.resume()
    }
    
    
    func navigate(token : String) {
        
        UserDefaults.standard.setValue(token, forKey: "token")
        let savedToken = UserDefaults.standard.value(forKey: "token") as! String
        UserDefaults.standard.removeObject(forKey: "token")
        
        self.performSegue(withIdentifier: "HomePageSegue", sender: nil)
    }
    
    
    
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
    }
    
    
}

