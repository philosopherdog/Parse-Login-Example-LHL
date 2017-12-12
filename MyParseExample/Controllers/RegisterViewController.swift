import UIKit

final class RegisterViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
}

// MARK: - IBActions

private extension RegisterViewController {
  @IBAction func signUpPressed(_ sender: UIBarButtonItem) {
    
    guard let userName = userTextField.text, let password = passwordTextField.text else {
      let error = R.error(with: "Please enter a valid user name and password")
      showErrorView(error)
      return
    }
    
    DataManager.signup(with: userName, and: password) { (success: Bool, error: Error?) in
      guard success == true else {
        self.showErrorView(error)
        return
      }
      self.performSegue(withIdentifier: R.wallPicturesTableViewController, sender: nil)
    }
  }
}
