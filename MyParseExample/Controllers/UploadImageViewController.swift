import UIKit
import Parse

final class UploadImageViewController: UIViewController {
  
  // MARK: - Properties
  var username: String?
  
  // MARK: - IBOutlets
  @IBOutlet weak var imageToUpload: UIImageView!
  @IBOutlet weak var commentTextField: UITextField!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
}

// MARK: - IBActions
extension UploadImageViewController {
  
  @IBAction func selectPicturePressed(_ sender: AnyObject) {
    // Open a UIImagePickerController to select the picture
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
  }
  
  @IBAction func sendPressed(_ sender: UIBarButtonItem) {
    commentTextField.resignFirstResponder()
    
    guard let commentText = commentTextField.text else {
      // provide a user alert here
      return
    }
    
    // Disable the send button until we are ready
    navigationItem.rightBarButtonItem?.isEnabled = false
    
    loadingSpinner.startAnimating()
    
    guard let uploadImage = imageToUpload.image,
      let pictureData = UIImagePNGRepresentation(uploadImage),
      let file = PFFile(name: "image", data: pictureData) else {
        loadingSpinner.stopAnimating()
        // warn user with an alert here
        return
    }
    
    DataManager.upload(file, and: commentText) {[unowned self] (success: Bool, error: Error?) in
      if let error = error {
        self.showErrorView(error)
      }
      if success == false {
        let successError = R.error(with: "Something went wrong, try again.")
        self.showErrorView(successError)
      }
      self.navigationController?.popViewController(animated: true)
    }
  }
}

// MARK: - UIImagePickerControllerDelegate

extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
    imageToUpload.image = image
    picker.dismiss(animated: true, completion: nil)
  }
}
