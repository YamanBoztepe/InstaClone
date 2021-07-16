//
//  RandomPhotosController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 11.07.2021.
//

import UIKit

class RandomPhotosController: BaseController {
    private let viewModel = PhotosViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnRowColumn: UIButton!
    
    private var isSingleRow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setCollectionView()
        updateUI()
    }
    
    // MARK: - Layout
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height/3)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(UINib(nibName: "FooterCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateUI() {
        viewModel.fetchCompleted = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.stopLoading()
                self.collectionView.reloadData()
            }
        }
        
        viewModel.errorHandler = { error in
            print(error)
        }
    }
    
    // MARK: - Fetch Photos
    private func fetchPhotos() {
        startLoading()
        viewModel.fetchPhotos()
    }
    
    // MARK: - Actions
    @IBAction func btnRowColumnPressed(_ sender: UIButton) {
        isSingleRow.toggle()
        
        if isSingleRow {
            btnRowColumn.setImage(UIImage(systemName: "rectangle.grid.1x2"), for: .normal)
            
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
            }
        } else {
            btnRowColumn.setImage(UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
            
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumLineSpacing = 1
                layout.minimumInteritemSpacing = 1
            }
        }
        
        collectionView.reloadData()
    }
    
}

// MARK: - CollectionView
extension RandomPhotosController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell()}
        cell.configure(with: viewModel.photoURLs[indexPath.row], at: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCell.identifier, for: indexPath) as? FooterCell else { return UICollectionReusableView() }
            
            viewModel.photoURLs.count > 0 ? footer.spinner.startAnimating() : footer.spinner.stopAnimating()
            footer.configure(with: viewModel)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthPerItem: CGFloat = 0
        var heightPerItem: CGFloat = 0
        
        if isSingleRow {
            if let customLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                widthPerItem = collectionView.frame.size.width - customLayout.minimumInteritemSpacing
                heightPerItem = view.frame.size.height / 3 - customLayout.minimumLineSpacing
            }
        } else {
            if let customLayout = collectionViewLayout as? UICollectionViewFlowLayout {
                widthPerItem = collectionView.frame.size.width / 3 - customLayout.minimumInteritemSpacing
                heightPerItem = view.frame.height / 5 - customLayout.minimumLineSpacing
            }
        }
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

// MARK: - ScrollView

extension RandomPhotosController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        
        if (currentPosition > collectionView.contentSize.height - scrollView.frame.height)
            && collectionView.contentSize.height > 0 {
            viewModel.fetchPhotos()
        }
    }
}

// MARK: - PhotoCellDelegate
extension RandomPhotosController: PhotoCellDelegate {
    func cellPressed(numberOfRow: Int) {
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "UserDetailsController") as? UserDetailsController {
            let userName = viewModel.photoInfos[numberOfRow].user.username
            vc.userName = userName
            present(vc, animated: true)
        }
    }
}
