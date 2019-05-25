//
//  ProfileViewController.swift
//  fakestagram
//
//  Created by LuisE on 4/23/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var authorView: PostAuthorView!
    @IBOutlet weak var previewPostsCollectionView: UICollectionView!
    
    var posts = [Post]()
    let cellId = "postThumbnailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewPostsCollectionView.delegate = self
        previewPostsCollectionView.dataSource = self
        loadAuthor()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadAuthor(){
        guard let acc = AccountRepo.shared.load() else { return }
        authorView.author = acc.toAuthor()
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = previewPostsCollectionView.frame.width / 3.0
        return CGSize(width: size, height: size)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .red
        return cell
    }
}
