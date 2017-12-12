import Foundation
import Parse

final class WallPost: PFObject {
  
  // MARK: - Properties
  @NSManaged var image: PFFile
  @NSManaged var user: PFUser
  @NSManaged var comment: String?
  
  // MARK: - Initializers
  init(image: PFFile, user: PFUser, comment: String?) {
    super.init()
    self.image = image
    self.user = user
    self.comment = comment
  }
  
  // Required otherwise the application crashes
  override init() {
    super.init()
  }
  
  // MARK: - Overridden
  override class func query() -> PFQuery<PFObject>? {
    let query = PFQuery(className: R.wallPost)
    query.includeKey("user")
    query.order(byDescending: "createdAt")
    return query
  }
}

// MARK: - PFSubclassing
extension WallPost: PFSubclassing {
  // required protocol method
  static func parseClassName() -> String {
    return R.wallPost
  }
}
