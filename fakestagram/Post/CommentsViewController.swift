//
//  CommentsViewController.swift
//  fakestagram
//
//  Created by Rodrigo Vivas on 8/2/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    public var row: Int = -1
    public var post: Post?
    public var author: Author?
    
    public var client: CommentClient?
    
    var tableClient = CommentsTableClient()
    
    var commentsArray: [Comment] = []
    
    let avatarView: SVGView = {
        let svg = SVGView()
        svg.translatesAutoresizingMaskIntoConstraints = false
        return svg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        client = CommentClient(post: self.post!)
        /*tableClient.show { [weak self] (data) in
            self?.commentsArray = data
        }*/
        tableClient.showComments(id: (post?.id)!) { [weak self] (data) in
            self?.commentsArray = data
        }
        commentTextField.delegate = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentTextField.resignFirstResponder()
        tableView.resignFirstResponder()
        publishButton.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableClient.showComments(id: (post?.id)!) { [weak self] (data) in
            self?.commentsArray = data
        }
        
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableClient.showComments(id: (post?.id)!) { [weak self] (data) in
            self?.commentsArray = data
        }
        
        
        tableView.reloadData()
    }
    
    func setupView() {
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: 52),
            avatarView.heightAnchor.constraint(equalToConstant: 52)
            ])
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 26

    }
    
    func reloadComments(){
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentsTableViewCell
        tableClient.showComments(id: (post?.id)!) { [weak self] (data) in
            self?.commentsArray = data
        }
        //cell.authorComment.text = commentsArray[indexPath.row].content
        cell.commentLabel.text = commentsArray[indexPath.row].content
        return cell
    }

    @IBAction func publishComment(_ sender: UIButton) {
        if commentTextField.text == ""{
            print("No se agregó ningún comentario")
        }else{
            if let content = commentTextField.text{
                
                let commentPayload = CreateComment(content: content)
                
                client?.create(content: commentPayload, success: { (comment) in
                    
                    print("")
                })
            }
            
            tableClient.showComments(id: (post?.id)!) { [weak self] (data) in
                self?.commentsArray = data
            }
            
            
            tableView.reloadData()
            commentTextField.text = ""
        }
        
    }
    
}

