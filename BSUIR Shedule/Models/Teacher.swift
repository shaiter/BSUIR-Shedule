//
//  Employee.swift
//  BSUIR Shedule
//
//  Created by Артём Шайтер on 5/27/18.
//  Copyright © 2018 Артём Шайтер. All rights reserved.
//

import UIKit

class Teacher:NSObject, NSCoding {
    
    var id: Int
    var fio: String
    var photo: UIImage = #imageLiteral(resourceName: "user")
    
    init(id: Int, fio: String, photo: UIImage = #imageLiteral(resourceName: "user")) {
        self.id = id
        self.fio = fio
        self.photo = photo
    }
    
    private struct PropertyKey {
        static let id = "id"
        static let fio = "fio"
        static let photo = "photo"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(fio, forKey: PropertyKey.fio)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: PropertyKey.id)
        let fio = aDecoder.decodeObject(forKey: PropertyKey.fio) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as! UIImage
        self.init(id: id, fio: fio, photo: photo)
        
    }
}
