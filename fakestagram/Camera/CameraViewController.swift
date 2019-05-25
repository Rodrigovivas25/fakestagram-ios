//
//  CameraViewController.swift
//  fakestagram
//
//  Created by José Gutiérrez D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let client = CreatePostClient()
    var imageController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSnap(_ sender: Any) {
        guard let img = UIImage(named: "meper"), let imgBase64 = img.encodedBase64() else { return }
        let payload = CreatePostBase64(title: "Meper donas - \(Date().currentTimestamp())", imageData: imgBase64)
        client.create(payload: payload){post in
            print(post)
        }
                
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        present(imageController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
