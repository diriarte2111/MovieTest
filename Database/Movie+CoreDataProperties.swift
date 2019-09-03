//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by David Iriarte on 9/3/19.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var isFavorite: Bool
    @NSManaged public var movieId: Int64

}
