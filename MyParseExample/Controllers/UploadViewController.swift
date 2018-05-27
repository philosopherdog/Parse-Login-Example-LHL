import UIKit
import Parse

final class UploadViewController: UIViewController {
  
  // MARK: - Properties
  private var username: String?
  
  // MARK: - IBOutlets
  @IBOutlet weak var sendButton: UIBarButtonItem! {
    didSet {
      sendButton.isEnabled = false
    }
  }
  @IBOutlet private weak var imageToUpload: UIImageView! {
    didSet {
      sendButton.isEnabled = imageToUpload == nil ? false : true
    }
  }
  
  @IBOutlet private weak var commentTextField: UITextField!
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

// MARK: - Select Action
extension UploadViewController {
  
  @IBAction private func selectPicturePressed(_ sender: AnyObject) {
    // Open a UIImagePickerController to select the picture
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
  }
}

// MARK: - UIImagePickerControllerDelegate

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
    imageToUpload.image = image
    picker.dismiss(animated: true, completion: nil)
  }
  
}

// MARK: - Send Action
extension UploadViewController {
  
  @IBAction private func sendPressed(_ sender: UIBarButtonItem) {
    
    commentTextField.resignFirstResponder()
    
    guard let commentText = commentTextField.text else {
      // provide a user alert here
      return
    }
    
    loadingSpinner.startAnimating()
    
    guard let uploadImage = imageToUpload.image,
      let pictureData = UIImagePNGRepresentation(uploadImage),
      let file = PFFile(name: "image", data: pictureData) else {
        loadingSpinner.stopAnimating()
        // warn user with an alert here
        return
    }
    
    DataManager.upload(file, and: commentText) {[weak self] (success: Bool, error: Error?) in
      
      if let error = error {
        self?.showErrorView(error)
      }
      
      if success == false {
        let successError = R.error(with: "Something went wrong, try again.")
        self?.showErrorView(successError)
      }
      
      // pop if the image was uploaded
      self?.navigationController?.popViewController(animated: true)
    }
  }
}


