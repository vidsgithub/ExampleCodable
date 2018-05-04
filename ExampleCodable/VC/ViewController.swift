//
//  ViewController.swift
//  ExampleCodable
//
//  Created by Shingade on 5/3/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var showGithub: UIButton!
    @IBOutlet weak var githubImage: UIImageView!
    @IBOutlet weak var gitHubName: UILabel!
    @IBOutlet weak var gitHubLoc: UILabel!
    @IBOutlet weak var gitHubFollowers: UILabel!
    @IBOutlet weak var gitHubRepo: UILabel!
    @IBOutlet weak var gitHubURL: UILabel!
    
    
    var myGitHubModel:MyGitHub?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideUIControls(status: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchGitHubData() {
        API.shared.getGitHubData(userName: (self.name.text?.lowercased())!, completionHandler: { (myGitHubObj) in
            self.myGitHubModel = myGitHubObj
            OperationQueue.main.addOperation {
                self.refreshUI()
            }
        })
    }
    
    func refreshUI() {
        self.hideUIControls(status: false)
        if let name = myGitHubModel?.name {
            self.gitHubName.text = name
        }
        if let loc = myGitHubModel?.location {
            self.gitHubLoc.text = loc
        }
        if let followers = myGitHubModel?.followers {
            self.gitHubFollowers.text = String(followers)
        }
        if let repo = myGitHubModel?.public_repo {
            self.gitHubRepo.text = String(repo)
        }
        if let avatarURL = myGitHubModel?.avatar_url {
            self.gitHubURL.text = avatarURL.absoluteString
        }
        // image
        guard let imgurl = self.myGitHubModel?.avatar_url else { return }
        if let imgData = try? Data.init(contentsOf: imgurl) {
            if let image = UIImage.init(data: imgData) {
                self.githubImage.image = image
            }
        }
    }
    
    func hideUIControls(status:Bool) {
        self.gitHubName.isHidden = status
        self.gitHubFollowers.isHidden = status
        self.gitHubRepo.isHidden = status
        self.gitHubURL.isHidden = status
        self.githubImage.isHidden = status
    }

    @IBAction func showGitHubAcc(_ sender: Any) {
        self.fetchGitHubData()
    }
}

