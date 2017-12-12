import Foundation

// MARK: - Resources

struct R {
  static let wallPicturesTableViewController = "WallPicturesTableViewController"
  
  static func error(with message: String) -> Error {
    let error = NSError(domain: "Custom", code: 100, userInfo: ["error" : message]) as Error
    return error
  }
  
  static let wallPost = "WallPost"
}


