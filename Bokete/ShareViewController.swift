//
//  ShareViewController.swift
//  Bokete
//
//  Created by 深谷祐斗 on 2020/06/04.
//  Copyright © 2020 yuto fukaya. All rights reserved.
//

import UIKit



class ShareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()

    
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
       
    }
    
    
    @IBAction func share(_ sender: Any) {
        
        //スクリーンショットを撮る
        takeScreenshot()
        
        //アクテビティービューにシェアする
        let items = [screenShotImage] as [Any]
        
        let activtyVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activtyVC,animated: true,completion: nil)
        
    }

    
    func takeScreenshot(){
        
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        // view に書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
    }
    
    
    @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
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
