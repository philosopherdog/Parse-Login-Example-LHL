import UIKit

final class RegisterViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet private weak var userTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  private func segue() {
    self.performSegue(withIdentifier: R.wallPicturesTableViewController, sender: nil)
  }
  
}

// MARK: - IBActions

private extension RegisterViewController {
  
  @IBAction func signUpPressed() {
    
    // Text input validation
    guard let userName = userTextField.text, let password = passwordTextField.text else {
      let error = R.error(with: "Please enter a valid user name and password")
      showErrorView(error)
      return
    }
    
    // Signup
    DataManager.signup(with: userName, and: password) {[weak self] (success: Bool, error: Error?) in
      guard success == true else {
        self?.showErrorView(error)
        return
      }
      self?.segue()
    }
  }
  
}
