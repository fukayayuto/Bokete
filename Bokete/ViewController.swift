//
//  ViewController.swift
//  Bokete
//
//  Created by 深谷祐斗 on 2020/06/04.
//  Copyright © 2020 yuto fukaya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    
   
    @IBOutlet weak var comentTextView: UITextView!
    
    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var searchComentText: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (states) in
            switch(states){
            case .authorized:break
            case .notDetermined:break
            case .restricted:break
            case .denied:break
            case .limited:break
            @unknown default:break
            }
        }
        
        getImage(keyword: "funny")
        
    }

    //検索キーワードの値をもとに画像を引っ張ってくる。
    //pic
    func getImage(keyword:String){
        
        
  
    let url = "https:pixabay.com/api/?key=16876062-83b159485146fab9c8329d29c&q=\(keyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success:
              var json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                }else{
                    
                    
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }
                
                
                
              
            
            case .failure(let error):
                
                print(error)
            }
        
        
        }
    
    
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
        
        if searchComentText.text == ""{

            getImage(keyword: "funny")
        }else{
            getImage(keyword: searchComentText.text!)
        }
    }
    
    @IBAction func seachAction(_ sender: Any) {
        self.count = 0
        
        if searchComentText.text == ""{

                   getImage(keyword: "funny")
               }else{
                   getImage(keyword: searchComentText.text!)
               }
        
    }
    
    
    
   
        
    @IBAction func next(_ sender: Any) {
    
    performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as! ShareViewController
        
        shareVC.commentString = comentTextView.text
        shareVC.resultImage = odaiImageView.image!
            }
    
}

