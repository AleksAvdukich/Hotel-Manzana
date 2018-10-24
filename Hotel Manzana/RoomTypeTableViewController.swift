//
//  RoomTypeTableViewController.swift
//  Hotel Manzana
//
//  Created by Aleksandr Avdukich on 24/10/2018.
//  Copyright © 2018 Sanel Avdukich. All rights reserved.
//

import UIKit

class RoomTypeTableViewController: UITableViewController {
    var roomTypes: [RoomType]!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roomTypes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeOfRoom", for: indexPath) as! TypeOfRoomTableViewCell

        cell.NameLabel.text = roomTypes[indexPath.row].name
        cell.shortNameLabel.text = roomTypes[indexPath.row].shortName
        cell.priceLabel.text = "$ \(roomTypes[indexPath.row].price.description)"

        return cell
    }
    

}
