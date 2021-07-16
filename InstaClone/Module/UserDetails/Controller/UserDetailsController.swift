//
//  UserDetailsController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 15.07.2021.
//

import UIKit
import Kingfisher

class UserDetailsController: BaseController {
    @IBOutlet weak var imgUserPhoto: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTotalPhotosCounter: UILabel!
    @IBOutlet weak var lblTotalLikesCounter: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = UserDetailsViewModel()
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
        setTableView()
        updateUI()
    }
    
    // MARK: - Layout
    private func setTableView() {
        tableView.register(UINib(nibName: "UserDetailCell", bundle: nil), forCellReuseIdentifier: UserDetailCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func updateUI() {
        viewModel.fetchCompleted = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setLayout()
                self.tableView.reloadData()
                self.stopLoading()
            }
        }
        viewModel.errorHandler = { error in
            print(error)
        }
    }
    
    private func setLayout() {
        lblUserName.text = viewModel.response?.name
        
        lblTotalPhotosCounter.text = "\(viewModel.response?.totalPhotos ?? 0)"
        lblTotalLikesCounter.text = "\(viewModel.response?.totalLikes ?? 0)"
        
        guard let url = URL(string: viewModel.response?.profileImage.medium ?? "") else { return }
        imgUserPhoto.kf.setImage(with: url)
        imgUserPhoto.layer.cornerRadius = 10
    }
    
    // MARK: - Fetch Data
    private func fetchUserDetails() {
        startLoading()
        viewModel.fetchDetails(for: userName!)
    }
}

// MARK: TableView
extension UserDetailsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.socialMedias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.identifier, for: indexPath) as? UserDetailCell else { return UITableViewCell() }
        cell.configure(with: viewModel.socialMedias[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height / 10
    }
}
