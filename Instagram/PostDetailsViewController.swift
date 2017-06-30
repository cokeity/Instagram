//
//  PostDetailsViewController.swift
//  Instagram
//
//  Created by Claire Chen on 6/28/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostDetailsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profImageView: PFImageView!
    
    //Variable
    var post: PFObject?
    //    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            print("Post found in Detail")
            captionLabel.text = post["caption"] as? String
            let likes = post["likesCount"] as! Int
            likesLabel.text = "Liked by " + String(likes)
            
            postImageView.file = post["media"] as? PFFile
            postImageView.loadInBackground()
            
            let curUser = PFUser.current()
            
            profImageView.file = curUser?.object(forKey: "prof_pic") as? PFFile
            profImageView.loadInBackground()
            profImageView.layer.borderWidth = 1
            profImageView.layer.masksToBounds = false
            profImageView.layer.borderColor = UIColor.black.cgColor
            profImageView.layer.cornerRadius = profImageView.frame.height/2
            profImageView.clipsToBounds = true
            
            if let user = post["author"] as? PFUser {
                print("We have a user in Detail")
                usernameLabel.text = user.username
            } else {
                print("No user found in Detail")
            }
        } else {
            print("No post found in Detail")
        }
        
        
        
        //some date formatting
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:post?.createdAt as! Date)
        timestampLabel.text = dateString
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
