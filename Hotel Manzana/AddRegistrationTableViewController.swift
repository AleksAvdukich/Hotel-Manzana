//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Aleksandr Avdukich on 18/10/2018.
//  Copyright © 2018 Sanel Avdukich. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfadultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var amountOfAdultsLabel: UILabel!
    @IBOutlet weak var amountOfChildrenLabel: UILabel!
    
    @IBOutlet weak var wiFiLabel: UILabel!
    @IBOutlet weak var wiFiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    var adultsCounter: Int = 2
    var childrenCounter: Int = 1
    var roomType: RoomType? {
        didSet {
            if let roomType = roomType {
                roomTypeLabel.text = roomType.shortName
            } else {
                roomTypeLabel.text = "not installed"
            }
        }
    }
    
    var roomTypes: [RoomType] = []
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday //мин до которой мы можем докрутить
        checkInDatePicker.date = midnightToday //текущая дата
        updateDateViews()
        
        numberOfadultsStepper.minimumValue = 0
        numberOfChildrenStepper.minimumValue = 0
        
        wiFiLabel.isHidden = true
        wiFiSwitch.isOn = false
        
        roomType = nil
        
        updateDateViews()
        updatePeopleViews()
        
        roomTypes = RoomType.createRooms()
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24) //добавляем день к выезду
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updatePeopleViews() {
        numberOfadultsStepper.value = Double(adultsCounter)
        numberOfChildrenStepper.value = Double(childrenCounter)
        
        amountOfAdultsLabel.text = Int(numberOfadultsStepper.value).description
        amountOfChildrenLabel.text = Int(numberOfChildrenStepper.value).description
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                print(#function, checkInDatePicker.frame.height)
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                print(#function, checkOutDatePicker.frame.height)
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            isCheckInDatePickerShown = false
            isCheckOutDatePickerShown = false
        }
        tableView.beginUpdates()//начнет вызывать методы для выбора/не выбора секций чтобы правильно отобразить наши tableView
        tableView.endUpdates()
        
        if indexPath.section == 4 {
            performSegue(withIdentifier: "showRoomType", sender: roomTypes)
        }
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let adults = amountOfAdultsLabel.text ?? ""
        let children = amountOfChildrenLabel.text ?? ""
        let wifi = wiFiSwitch.isOn ? "You need to pay ($10) for wi-fi" : "No wi-fi"
        
        
        print(#function)
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(email)")
        print("Check In: \(checkInDate)")
        print("Check In: \(checkOutDate)")
        print(adults)
        print(children)
        print(wifi)
        print(roomType?.shortName ?? "Room type not selected")
        
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func amountOfAdultsStepper(_ sender: UIStepper) {
        
        let senderValueString = String(Int(sender.value))
        amountOfAdultsLabel.text = senderValueString
    }
    
    @IBAction func amountOfChildrenStepper(_ sender: UIStepper) {
        
        let senderValueString = String(Int(sender.value))
        amountOfChildrenLabel.text = senderValueString
    }
    
    @IBAction func wifiSwitchAction(_ sender: UISwitch) {
        self.view.endEditing(true)
        wiFiLabel.isHidden = !sender.isOn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRoomType",
            let roomTypes = sender as? [RoomType] {
            let dnc = segue.destination as! UINavigationController
            let dvc = dnc.topViewController as! RoomTypeTableViewController
            
            dvc.roomTypes = roomTypes
        }
    }
    
    @IBAction func unwindFromRoomType(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindFromRoomType",
        let sourceVC = segue.source as? RoomTypeTableViewController,
        let selectedRow = sourceVC.tableView.indexPathForSelectedRow?.row
        else { return }
        
        roomType = roomTypes[selectedRow]
    }
    
    
}
