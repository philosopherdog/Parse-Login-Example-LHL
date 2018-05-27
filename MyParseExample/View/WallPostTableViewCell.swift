import UIKit
import Parse

final class WallPostTableViewCell: PFTableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet private weak var postImage: PFImageView!
  @IBOutlet private weak var createdByLabel: UILabel!
  @IBOutlet private weak var commentLabel: UILabel!
  @IBOutlet private weak var progressView: UIProgressView!
  
  internal var wallPost: WallPost! {
    didSet {
      postImage.file = wallPost.image
      postImage.loadInBackground()
      createdByLabel.text = wallPost.user.username
      commentLabel.text = wallPost.comment
    }
  }
}
