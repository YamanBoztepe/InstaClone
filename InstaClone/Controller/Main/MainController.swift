//
//  MainController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 21.06.2021.
//

import UIKit

class MainController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let viewModel = MainViewModel()
    
    private var photos = [UIImage]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private var numberOfPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhotos()
        setLayout()
        
    }
    
    
    // MARK: - Setting UI
    private func setLayout() {
        setCollectionView()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds

        setNavigatonLayout()
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height/3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(FooterSpinnerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterSpinnerView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setNavigatonLayout() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - Fetching Photos
    private func fetchPhotos() {
        viewModel.fetchPhotos { [weak self] (photos) in
            self?.photos = photos
        }
    }

}


// MARK: - TableView
extension MainController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterSpinnerView.identifier, for: indexPath) as? FooterSpinnerView else { return UICollectionReusableView() }
            
            if photos.count > 0 {
                footer.spinner.startAnimating()
            }
            return footer
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        CGSize(width: view.frame.width, height: 30)
    }
    
}


// MARK: - ScrollView
extension MainController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        
        if (currentPosition > collectionView.contentSize.height - scrollView.frame.height)
            && collectionView.contentSize.height > 0 {
            
            if viewModel.fetchStatus != .fetching {
                numberOfPage += 1
                viewModel.fetchPhotos(page: numberOfPage) { [weak self] (photos) in
                    self?.photos.append(contentsOf: photos)
                }
            }
            
        }
    }
}
