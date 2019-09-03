//
//  SecondViewController.swift
//  MovieUI
//
//  Created by David Iriarte on 9/2/19.
//  Copyright © 2019 DavidIriarte. All rights reserved.
//

import UIKit

class SecondViewController: FirstViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Favorites"
        hideFavorite = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfo()
    }
    
    override func getInfo(){
        movies = MovieManager.getAllFavoriteMovies()
        moviesCollectionView.reloadData()
    }
}

