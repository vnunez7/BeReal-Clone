//
//  PostCell.swift
//  BeReal Clone
//
//  Created by Victoria Nunez on 4/5/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        if let user = post.user {
            usernameLabel.text = user.username
        }

        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    self?.postImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        captionLabel.text = post.caption

        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil

        imageDataRequest?.cancel()
    }
}

