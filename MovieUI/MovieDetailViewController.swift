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
    
    var movie : Movie!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var synopsisTextView: UITextView!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var imageURL : String!{
        willSet{
            guard let url = newValue else {
                print("No tiene poster");
                self.imageView.image = UIImage.init(named: "no_poster_available")
                return
            }
            
            let imageCompleteURL = baseURL + url
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

        //synopsisTextView.font = UIFont(name: "HelveticaRoundedLTStd-BdCn", size: 16)
//        self.title = infoJSON["title"].string
//        self.imageURL = infoJSON["poster_path"].string
//        synopsisTextView.text = infoJSON["overview"].string
//        rateLabel.text = String(describing: infoJSON["vote_average"].number!.floatValue)
        
        title = movie.title
        imageURL = movie.poster_path
        synopsisTextView.text = movie.overview
        rateLabel.text = String(movie.vote_average)
    }

}
