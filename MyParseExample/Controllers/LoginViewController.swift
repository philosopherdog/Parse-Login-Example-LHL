import UIKit

final class LoginViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var userTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  private func segue() {
    performSegue(withIdentifier: R.wallPicturesTableViewController, sender: nil)
  }
}

// MARK: - Life Cycle

extension LoginViewController {
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    checkLoginState()
  }
  
  private func checkLoginState() {
    DataManager.checkUserLoginState { (success: Bool) in
      print(#line, success ? "": "not ", "auto logged in")
      if success {
        self.segue()
      }
    }
  }
  
}

// MARK: - IBActions

private extension LoginViewController {
  
  @IBAction private func loginTapped(_ sender: AnyObject) {
    
    // Validate text input
    guard let username = userTextField.text,
      let password = passwordTextField.text else {
        let error = R.error(with: "Username and Password fields cannot be empty. Please enter and try again!")
        showErrorView(error)
        return
    }
    
    // Log in
    DataManager.login(with: username, and: password) { (success: Bool, error: Error?) in
      guard error == nil, success == true else {
        print(#line, "not logged in")
        self.showErrorView(error)
        return
      }
      self.segue()
    }
  }
}
