//
//  SearchPhotosController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 27.06.2021.
//

import UIKit

class SearchPhotosController: BaseController {
    @IBOutlet weak var lblSearchInfo: UILabel!
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    private let viewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTexts()
        setTextField()
        addAttributesToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        txtSearchBar.text = nil
    }
    
    // MARK: - Layout
    private func animateTexts() {
        UIView.animate(withDuration: 2.0) { [weak self] in
            guard let self = self else { return }
            self.lblSearchInfo.alpha = 1
        }
    }
    
    private func setTextField() {
        txtSearchBar.delegate = self
    }
    
    private func addAttributesToView() {
        view.keyboardShowObserver()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewPressed))
        view.addGestureRecognizer(tapGesture)
    }
    @objc private func viewPressed() {
        view.endEditing(true)
    }
    
}

// MARK: - Textfield
extension SearchPhotosController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        lblErrorMessage.text = ""
        
        if let text = textField.text, text.count > 0 {
            startLoading()
            if viewModel.photoURLs.count > 0 { viewModel.removeAllPhotos() }
            viewModel.textToSearch = text
            viewModel.photosFetched  = { [weak self] in
                guard let self = self else { return }
                if self.viewModel.photoURLs.count > 0 {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self, let vc = self.storyboard?.instantiateViewController(identifier: "PhotoResultsController") as? PhotoResultsController else { return }
                        vc.searchText = text
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    self.lblErrorMessage.text = "We can't find photos that you want :("
                }
                self.stopLoading()
            }
        } else {
            lblErrorMessage.text = "Please type something"
            stopLoading()
            return true
        }
        return true
    }
}
