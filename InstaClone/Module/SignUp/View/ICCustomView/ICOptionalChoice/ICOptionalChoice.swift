//
//  ICOptionalChoice.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 18.07.2021.
//

import UIKit

class ICOptionalChoice: UIView {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var options: [String]?
    private var tappedOption: Int?
    private(set) var selectedOption: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createNibView(nibName: "ICOptionalChoice")
        setTableView()
    }
    
    // MARK: - Layout
    func setTitle(_ title: String) {
        lblTitle.text = title
    }
    
    func addOptions(_ options: [String]) {
        self.options = options
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "ICOptionalChoiceCell", bundle: nil), forCellReuseIdentifier: ICOptionalChoiceCell.identifier)
        tableView.dataSource = self
    }
}

// MARK: - TableView
extension ICOptionalChoice: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ICOptionalChoiceCell.identifier, for: indexPath) as? ICOptionalChoiceCell else { return UITableViewCell() }
        
        if let optionName = options?[indexPath.row] {
            cell.configure(with: optionName, at: indexPath.row)
        }
        
        if let tappedOption = tappedOption {
            cell.optionSelected = tappedOption == indexPath.row
        } else {
            if indexPath.row == 0 {
                cell.optionSelected = true
            } else {
                cell.optionSelected = false
            }
        }
        
        cell.delegate = self
        return cell
    }
}

// MARK: - ICOptionalChoiceCellProtocol
extension ICOptionalChoice: ICOptionalChoiceCellProtocol {
    
    func btnOptionTapped(numberOfRow: Int) {
        if let selectedOption = options?[numberOfRow] {
            self.selectedOption = selectedOption
        }
        
        tappedOption = numberOfRow
        tableView.reloadData()
    }
}
