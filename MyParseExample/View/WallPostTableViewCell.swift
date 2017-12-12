import UIKit
import ParseUI

final class WallPostTableViewCell: PFTableViewCell {
  
  // MARK: - IBOutlets
   var wallPost: WallPost! {
    didSet {
      postImage.file = wallPost.image
      postImage.loadInBackground()
      createdByLabel.text = wallPost.user.username
      commentLabel.text = wallPost.comment
    }
  }
  @IBOutlet weak var postImage: PFImageView!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
}
