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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        viewModel.fetchPhotos()
        updateUI()
    }
    
    // MARK: - Setting UI
    private func setLayout() {
        setCollectionView()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        title = "Photos"
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height/2.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.register(FooterSpinnerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterSpinnerView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func updateUI() {
        viewModel.photosFetched = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}



// MARK: - TableView
extension MainController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        let photoURL = viewModel.photoURLs[indexPath.row]
        cell.configure(with: photoURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterSpinnerView.identifier, for: indexPath) as? FooterSpinnerView else { return UICollectionReusableView() }
            
            if viewModel.photoURLs.count > 0 {
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
            viewModel.fetchMorePhotosIfPossible()
        }
    }
}
