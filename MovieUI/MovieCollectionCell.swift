//
//  MovieCollectionCell.swift
//  putuPutuSwift
//
//  Created by David Iriarte on 5/7/19.
//  Copyright © 2019 Jakare. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

//import DGActivityIndicatorView

class MovieCollectionCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    var ratingLabel : UILabel!
    var titleLabel : UILabel!
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    var favoriteButton : UIButton!
    
    
    
//    var activityIndicatorView :DGActivityIndicatorView!
//    var stationO : StationO! {
//        willSet{
//            titleLabel.text = newValue.name
//            descriptionLabel.text = newValue.descripcion
//            self.downloadImage(from:NSURL(string:newValue.image_url)! as URL)
//            self.setNeedsLayout()
//        }
//    }
    
    var imageURL : String!{
        willSet{
            let imageCompleteURL = baseURL + newValue
            print("ImageComplete \(imageCompleteURL)")
            Alamofire.request(imageCompleteURL).responseImage { response in
                //debugPrint(response)
                
                //print(response.request)
                //print(response.response)
                //debugPrint(response.result)
                
                if let image = response.result.value {
                    self.imageView.image = image
                  //  print("image downloaded: \(image)")
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        
        imageView = UIImageView.init()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
//        activityIndicatorView = DGActivityIndicatorView(type: .ballPulse, tintColor: UIColor.white, size: 50.0)
//
//        self.imageView.addSubview(activityIndicatorView)
//        activityIndicatorView.startAnimating()
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white//UIColor.init(red: 161/255, green: 116/255, blue: 46/255, alpha: 1)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "HelveticaRoundedLTStd-BdCn", size: 14)
        contentView.addSubview(titleLabel)
        
        favoriteButton = UIButton.init(type: .custom)
        favoriteButton.backgroundColor = UIColor.red
        //favoriteButton.addTarget(self, action: #selector(favoriteButtonTouched:), for:.tou)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTouched), for:.touchUpInside)
        contentView.addSubview(favoriteButton)
        
        ratingLabel = UILabel.init()
        ratingLabel.backgroundColor = UIColor.clear
        ratingLabel.textColor = UIColor.white
        ratingLabel.numberOfLines = 0
        ratingLabel.font = UIFont(name: "HelveticaRoundedLTStd-BdCn", size: 14)
        ratingLabel.textAlignment = .right
        contentView.addSubview(ratingLabel)
        
//        descriptionLabel = UILabel.init()
//        descriptionLabel.textColor = UIColor.white
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.font = UIFont(name: "HelveticaRoundedLTStd-BdCn", size: 16)
//        descriptionLabel.textAlignment = .left
//        contentView.addSubview(descriptionLabel)
    }
    
    @objc func favoriteButtonTouched(_ button:UIButton){
        print("Touched favorite")
        button.isSelected = !button.isSelected
        button.backgroundColor = button.isSelected ? UIColor.blue: UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.resizeSubviews()
    }
    
    func resizeSubviews(){
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 250)
        favoriteButton.frame = CGRect (x:self.frame.width - 35,y:5, width: 30, height: 30)
        let originY : CGFloat = imageView.frame.maxY
        ratingLabel.frame = CGRect(x:self.frame.width - 35, y: originY, width: 30, height:self.frame.size.height - originY)
        titleLabel.frame = CGRect(x: 0, y: originY, width:ratingLabel.frame.origin.x, height: self.frame.size.height - originY)
        
        //let descriptionText = descriptionLabel.text! as NSString
        
        //let descriptionSize = descriptionText.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: descriptionLabel.font!], context: nil)
       // descriptionLabel.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 5, width: self.frame.width, height: descriptionSize.height)
        //activityIndicatorView.frame = CGRect(x: (imageView.frame.width - 50)/2, y: (imageView.frame.height - 50)/2, width: 50, height: 50)
    }
    
//    func downloadImage(from url: URL) {
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async() {
//                self.activityIndicatorView.stopAnimating()
//                self.activityIndicatorView.removeFromSuperview()
//                self.imageView.image = UIImage(data: data)
//            }
//        }
//    }
//
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//    }
}
