//
//  DetailViewController.swift
//  Instagram
//
//  Created by Kristine Laranjo on 2/28/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    var instagramPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postImageView.file = instagramPost["media"] as? PFFile
        let author = instagramPost["_p_author"] as? PFUser
        self.authorLabel.text = author?.username
        self.captionLabel.text = instagramPost["caption"] as? String
        
        //format date
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        // Convert Date to String
        let createdAtString = formatter.string(from: instagramPost.createdAt!)
        
        self.timestampLabel.text = createdAtString
        self.postImageView.loadInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}
