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
    
    var movieObject : Movie!{
        willSet{
            self.titleLabel.text = newValue.title
            self.ratingLabel.text = String(newValue.vote_average)
            self.imageURL = newValue.poster_path
            self.favoriteButton.isSelected = newValue.isFavorite
        }
    }
    
    
    
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
            guard let url = newValue else {
                print("No tiene poster");
                
                self.imageView.image = UIImage.init(named: "no_poster_available")
                return
            }
            
            let imageCompleteURL = baseURL + url
            //print("ImageComplete \(imageCompleteURL)")
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
        favoriteButton.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.setImage(UIImage.init(named: "favorite_unselected"), for: .normal)
        favoriteButton.setImage(UIImage.init(named: "favorite_selected"), for: .selected)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTouched), for:.touchUpInside)
        contentView.addSubview(favoriteButton)
        
        ratingLabel = UILabel.init()
        ratingLabel.backgroundColor = UIColor.clear
        ratingLabel.textColor = UIColor.white
        ratingLabel.numberOfLines = 0
        ratingLabel.font = UIFont(name: "HelveticaRoundedLTStd-BdCn", size: 14)
        ratingLabel.textAlignment = .right
        contentView.addSubview(ratingLabel)
    }
    
    @objc func favoriteButtonTouched(_ button:UIButton){
        print("Touched favorite")
        button.isSelected = !button.isSelected
        MovieManager.saveAsFavorite(button.isSelected, movieId: movieObject.movieId)
        //button.backgroundColor = button.isSelected ? UIColor.blue: UIColor.red
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
        favoriteButton.frame = CGRect (x:self.frame.width - 35, y:5, width: 30, height: 30)
        let originY : CGFloat = imageView.frame.maxY
        ratingLabel.frame = CGRect(x:self.frame.width - 35, y: originY, width: 30, height:self.frame.size.height - originY)
        titleLabel.frame = CGRect(x: 0, y: originY, width:ratingLabel.frame.origin.x, height: self.frame.size.height - originY)
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.image = nil
//    }
}
