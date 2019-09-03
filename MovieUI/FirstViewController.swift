//
//  FirstViewController.swift
//  MovieUI
//
//  Created by David Iriarte on 9/2/19.
//  Copyright © 2019 DavidIriarte. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class FirstViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var filtered : [JSON] = []
    fileprivate var filterring = false
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var selectedJSON : JSON!
    
    let baseURL = "https://api.themoviedb.org/3/discover/movie?api_key=e0f8cd821313d7bf4362d6fab32ae53e&primary_release_year=2019&page=1"
    
    //let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    var movies : [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies 2019"
        let collectionLayout = UICollectionViewFlowLayout.init()
        collectionLayout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        collectionLayout.minimumInteritemSpacing = 15
        collectionLayout.minimumLineSpacing = 25
        
//        let searchBar = UISearchBar()
//        searchBar.delegate = self;
//        searchBar.sizeToFit()
        //navigationItem.leftBarButtonItem = searchBar
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.definesPresentationContext = true
        self.navigationItem.searchController = search
        
//        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
//        navigationItem.leftBarButtonItem = leftNavBarButton

        moviesCollectionView.collectionViewLayout = collectionLayout
        moviesCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        
        getValueData(url: baseURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    func getValueData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got data")
                    let valueJSON : JSON = JSON(response.result.value!)
                    print(valueJSON)
                    self.updateValueData(json: valueJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }
    
    func updateValueData(json : JSON) {
        
        if let tempResult = json["results"].array {
            movies = tempResult
            moviesCollectionView .reloadData()
        }else{
          //  bitcoinPriceLabel.text = "No available. Check your internet connection"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMovieDetail" {
            
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.infoJSON = selectedJSON
            
        }
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
     
        return true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print("Search text \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print ("Search text \(searchBar.text!)")
    }
    
    
   // optional func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
    
//    @available(iOS 2.0, *)
//    optional func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
//
//    @available(iOS 2.0, *)
//    optional func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool // return NO to not resign first responder
//
//    @available(iOS 2.0, *)
//    optional func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
    
//    @available(iOS 2.0, *)
//    optional func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            //let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", text)
            self.filtered = self.movies.filter { (JSONObject) -> Bool in
                print(JSONObject["title"].string!)
                print("Text \(text)")
                return  JSONObject["title"].string!.lowercased().contains(text.lowercased())
            }
            
            //self.filtered = self.countries.filter({ (country) -> Bool in
              //  return country.lowercased().contains(text.lowercased())
            //})
            self.filterring = true
        }
        else {
            self.filterring = false
            self.filtered = []
        }
        self.moviesCollectionView.reloadData()
    }
}

extension FirstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return movies.count
        
        return self.filterring ? self.filtered.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionCell
        
        let movie = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
       
        cell.titleLabel.text = movie["title"].string
        cell.imageURL = movie["poster_path"].string
        cell.ratingLabel.text = String(describing: movie["vote_average"].number!.floatValue)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: (self.view.frame.width - 45)/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedJSON = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
        self.performSegue(withIdentifier: "showMovieDetail", sender: self)
    }
}

