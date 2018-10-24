//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Aleksandr Avdukich on 18/10/2018.
//  Copyright © 2018 Sanel Avdukich. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailaddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable {
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return rhs.id == lhs.id //или наоборот lhs == rhs без разницы
    }
    
    static func createRooms() -> [RoomType] {
        let rooms = [
            RoomType(id: 1, name: "Single Room", shortName: "SR", price: 100),
            RoomType(id: 2, name: "Double Room", shortName: "DR", price: 200),
            RoomType(id: 3, name: "Triple Room", shortName: "TR", price: 300),
            RoomType(id: 4, name: "Lux", shortName: "L", price: 500)]
        
        return rooms
    }
    
}
