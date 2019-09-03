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
    
    //var filtered : [JSON] = []
    fileprivate var filterring = false
    
    var isWaiting = false
    var pageNumber = 1
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var selectedJSON : JSON!
    
    var baseURL = "https://api.themoviedb.org/3/discover/movie?api_key=e0f8cd821313d7bf4362d6fab32ae53e&primary_release_year=2019&page="
    
    //let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    var movies : [Movie] = []
    var filtered : [Movie] = []
    
    var selectedMovie : Movie!
    
    var hideFavorite : Bool! = false
    
   
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
        self.navigationItem.hidesSearchBarWhenScrolling = false
        

        moviesCollectionView.collectionViewLayout = collectionLayout
        moviesCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        
        // let urlToPass = baseURL + String(pageNumber)
        
        //getValueData(url: urlToPass)
        
//       movies = MovieManager.getAllMovies()
        
     
        getInfo()
        
    }
    
    func getInfo(){
        let handlerBlockUser: ([Movie]) -> Void = { moviesArray in
            self.movies = moviesArray
            self.moviesCollectionView.reloadData()
        }
        
        MovieManager.getAllMovies(completionHandler: handlerBlockUser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let handlerBlockUser: ([Movie]) -> Void = { movies in
//            self.movies = movies
//            self.moviesCollectionView.reloadData()
//        }
//        
//        MovieManager.callAPIService(completionHandler: handlerBlockUser)
        
        
    }
    
//    func getValueData(url: String) {
//        Alamofire.request(url, method: .get)
//            .responseJSON { response in
//                if response.result.isSuccess {
//
//                    print("Sucess! Got data")
//                    let valueJSON : JSON = JSON(response.result.value!)
//                    print(valueJSON)
//                    self.updateValueData(json: valueJSON)
//                    self.saveToDataBase(json:valueJSON)
//
//                } else {
//                    print("Error: \(String(describing: response.result.error))")
//                }
//        }
//    }
    
//    func saveToDataBase(json:JSON){
//        //for movie in json["results"].array?.count{
//
//        //}
//
//        for movie in json["results"].arrayValue {
//            print(movie["title"].stringValue)
//
//            MovieManager.addMovie(movieJson: movie)
//
//        }
//    }
    
    /*func updateValueData(json : JSON) {
        
        if let tempResult = json["results"].array {
            movies.append(contentsOf: tempResult)
            moviesCollectionView.reloadData()
        }else{
          //  bitcoinPriceLabel.text = "No available. Check your internet connection"
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMovieDetail" {
            
            let destinationVC = segue.destination as! MovieDetailViewController
            //destinationVC.infoJSON = selectedJSON
            
            destinationVC.movie = selectedMovie
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
           
            self.filtered = movies.filter{ $0.title!.lowercased().contains(text.lowercased())}
            
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
    
    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//
//        return true
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //print("Search text \(searchText)")
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print ("Search text \(searchBar.text!)")
//    }
    
    
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
    
    /*func updateSearchResults(for searchController: UISearchController) {
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
    }*/
}

extension FirstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return movies.count
        
        return self.filterring ? self.filtered.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionCell
        
        cell.movieObject = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
        
        cell.favoriteButton.isHidden = hideFavorite
        
        //let movie = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
       
//        cell.titleLabel.text = movie["title"].string
//        cell.imageURL = movie["poster_path"].string
//        cell.ratingLabel.text = String(describing: movie["vote_average"].number!.floatValue)
        
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: (self.view.frame.width - 45)/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.selectedJSON = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
        //self.performSegue(withIdentifier: "showMovieDetail", sender: self)
        
        self.selectedMovie = self.filterring ? self.filtered[indexPath.row] : movies[indexPath.row]
        self.performSegue(withIdentifier: "showMovieDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // Note: ‘isWating’ is used for checking the paging status Is currency process or not.
        if indexPath.row == self.movies.count - 2 && !isWaiting {
            isWaiting = true
            self.pageNumber += 1
            self.doPaging()
        }
    }

    
    private func doPaging() {
        
        
        let urlToPass = baseURL + String(pageNumber)
        //getValueData(url: urlToPass)
        isWaiting = false
        // call the API in this block and after getting the response then
        
       // self.dataSoruce.append(newData);
       // self.tableView.reloadData()
       // self.isWating = false // it’s means paging is done and user can able request another page request by scrolling the tableview at the bottom.
        
    }
    
}

