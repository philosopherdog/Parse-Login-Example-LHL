import Foundation
import Parse

class DataManager {
  
  //MARK: - Login
  
  static func checkUserLoginState(completion: (Bool) -> Void) {
    completion(PFUser.current()?.isAuthenticated ?? false)
  }
  
  static func signup(with userName: String, and password: String, completion: @escaping (Bool, Error?)-> Void) {
    let user = PFUser()
    user.username = userName
    user.password = password
    user.signUpInBackground { success, error in
      completion(success, error)
    }
  }
  
  static func login(with userName: String, and password: String, completion:@escaping (Bool, Error?)-> Void) {
    PFUser.logInWithUsername(inBackground: userName, password: password) { user, error in
      guard let _ = user else {
        completion(false, error)
        return
      }
      completion(true, nil)
    }
  }
  
  //MARK: - Fetch/Upload
  
  static func fetchAllPosts(with completion: @escaping ([WallPost]?, Error?) -> Void ) {
    guard let query = WallPost.query() else {
      completion(nil, R.error(with: "Couldn't generate a query, please try again."))
      return
    }
    query.findObjectsInBackground {(objects: [PFObject]?, error: Error?) in
      guard let objects = objects as? [WallPost] else {
        completion(nil, error)
        return
      }
      completion(objects, nil)
    }
  }
  
  static func upload(_ file: PFFile, and comment: String, completion:@escaping (Bool, Error?) -> Void) {
    
    DataManager.checkUserLoginState(completion: { (loggedIn: Bool) in
      if !loggedIn {
        return completion(false, R.error(with: "No current user"))
      }
    })
    
    let user = PFUser.current()!
    
    file.saveInBackground({ success, error in
      if error != nil {
        return completion(success, error)
      }
      
      guard success == true else {
        return completion(success, R.error(with: "File upload not successful, try again"))
      }
      
      let wallPost = WallPost(image: file, user: user, comment: comment)
      wallPost.saveInBackground { success, error in
        completion(success, error)
      }
    }, progressBlock: { percent in
      print("Uploaded: \(percent)%")
    })
  }
  
  
}
