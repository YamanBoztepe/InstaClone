//
//  ICBirthDate.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 18.07.2021.
//

import UIKit

class ICBirthDate: UIView {
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    private(set) var selectedDate: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createNibView(nibName: "ICBirthDate")
        
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        guard let day = components.day,
              let month = components.month,
              let year = components.year else { return }
        
        selectedDate = "\(day).\(month).\(year)"
    }
}
