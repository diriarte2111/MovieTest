//
//  MovieDetailViewController.swift
//  MovieUI
//
//  Created by David Iriarte on 9/2/19.
//  Copyright © 2019 DavidIriarte. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    var infoJSON : JSON! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var imageURL : String!{
        willSet{
            let imageCompleteURL = baseURL + newValue
            print("ImageComplete \(imageCompleteURL)")
            Alamofire.request(imageCompleteURL).responseImage { response in
                
                if let image = response.result.value {
                    self.imageView.image = image
                    //  print("image downloaded: \(image)")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blue
        self.title = infoJSON["title"].string
        self.imageURL = infoJSON["poster_path"].string

        // Do any additional setup after loading the view.
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
