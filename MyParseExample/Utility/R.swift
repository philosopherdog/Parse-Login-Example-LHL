import Foundation

// MARK: - Resources

struct R {
  static let wallPicturesTableViewController = "WallPicturesTableViewController"
  static let wallPost = "WallPost"
  
  static func error(with message: String, code: Int = 100) -> Error {
    let error = NSError(domain: "Custom", code: code, userInfo: ["error" : message]) as Error
    return error
  }
}


