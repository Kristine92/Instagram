//
//  HomeViewController.swift
//  Instagram
//
//  Created by Kristine Laranjo on 2/25/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        fetchPosts(refresh: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        self.performSegue(withIdentifier: "addPhoto", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        cell.instagramPost = posts[indexPath.row]
        
        return cell
    }
    
    @objc func fetchPosts(refresh: UIRefreshControl){
        let query = Post.query()
        query?.limit = 20
        query?.order(byDescending: "_created_at")
        query?.findObjectsInBackground(block: { (posts, error) in
            if(posts != nil){
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                refresh.endRefreshing()
            } else{
                print(error?.localizedDescription)
            }
        })
    }
    
    @IBAction func didLogout(_ sender: Any) {
        print("Logged out")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.instagramPost = post
        }
    }
    
}
