//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Kristine Laranjo on 2/26/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            self.postCaptionLabel.text = instagramPost["caption"] as? String
            self.postImageView.file = instagramPost["media"] as? PFFile
            self.postImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
