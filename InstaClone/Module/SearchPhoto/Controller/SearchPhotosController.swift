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
    
    private let viewModel = SearchPhotosViewModel()
    
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
        
        do {
            try viewModel.check(text: textField.text)
            
        } catch SearchTextError.NilText {
            lblErrorMessage.text = SearchTextError.NilText.rawValue
            return false
            
        } catch SearchTextError.InvalidText {
            lblErrorMessage.text = SearchTextError.InvalidText.rawValue
            return false
            
        } catch {
            lblErrorMessage.text = "We don't understand about what you write"
            return false
            
        }
        
        let storyboard = UIStoryboard(name: "PhotoResults", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "PhotoResultsController") as? PhotoResultsController else { return false }
        vc.searchText = textField.text!
        self.navigationController?.pushViewController(vc, animated: true)
        return true
    }
}
