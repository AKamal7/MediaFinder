import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 3, bottom: 5, right: 3))
    }
    
    func configurecell(media: MyMovie) {
        if media.getKind() == MediaType.tvShow {
            titleLabel?.text = media.artistName
        } else {
            titleLabel?.text = media.trackName
        }
        if media.getKind() == MediaType.music {
            longDescriptionLabel?.text = media.artistName
        } else {
            longDescriptionLabel?.text = media.longDescription
        }
        mediaImageView?.sd_setImage(with: URL(string: media.artworkUrl100), completed: nil)
    }
    
    
}
