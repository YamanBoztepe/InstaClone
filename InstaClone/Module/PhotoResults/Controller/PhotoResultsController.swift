//
//  PhotoResultsController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 28.06.2021.
//

import UIKit


class PhotoResultsController: BaseController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = PhotosViewModel()
    var searchText = "" {
        didSet {
            viewModel.textToSearch = searchText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setLayout()
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
    
    private func setLayout() {
        navigationController?.navigationBar.isHidden = false
        title = searchText
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func updateUI() {
        viewModel.fetchCompleted = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        showError()
    }
    
    private func showError() {
        viewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.setAlert(with: error)
            }
        }
    }
    
    private func setAlert(with error: Error) {
        let alert = UIAlertController(title: "We can't show photos :(",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
}

// MARK: - CollectionView
extension PhotoResultsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.photoURLs[indexPath.row], at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCell.identifier, for: indexPath) as? FooterCell else { return UICollectionReusableView() }
            
            if viewModel.photoURLs.count > 0 {
                footer.spinner.startAnimating()
            }
            footer.configure(with: viewModel)
            
            return footer
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 30)
    }
    
}

// MARK: - ScrollView
extension PhotoResultsController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        
        if (currentPosition > collectionView.contentSize.height - scrollView.frame.height)
            && collectionView.contentSize.height > 0 {
            viewModel.textToSearch = searchText
        }
    }
}
