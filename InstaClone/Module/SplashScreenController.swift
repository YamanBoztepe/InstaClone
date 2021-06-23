//
//  SplashScreenController.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 22.06.2021.
//

import UIKit

class SplashScreenController: UIViewController {
    
    private let imgInstagram: UIImageView = {
        let img = UIImageView()
        img.frame = .init(x: 0, y: 0, width: 150, height: 150)
        img.image = UIImage(named: "instagramLogo")
        return img
    }()
    
    private let mainController: UINavigationController = {
        let nv = UINavigationController(rootViewController: MainController())
        nv.modalTransitionStyle = .crossDissolve
        nv.modalPresentationStyle = .fullScreen
        return nv
    }()
    
    private let lblAppcent: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        
        let appcentMutableAttrText = NSMutableAttributedString(string: "from\n", attributes: [
                                                                NSAttributedString.Key.foregroundColor : UIColor.systemGray,
                                                                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        
        let appcentAttrText = NSAttributedString(string: "Appcent", attributes: [
                                                NSAttributedString.Key.foregroundColor : UIColor.systemOrange,
                                                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        
        appcentMutableAttrText.append(appcentAttrText)
        lbl.attributedText = appcentMutableAttrText
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.animate()
        }
    }
    
    
    private func animate() {
        
        let size = view.frame.size.width * 2
        let center = view.center
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.imgInstagram.frame.size.width = size
            self.imgInstagram.frame.size.height = size
            self.imgInstagram.center = center
        }
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.imgInstagram.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.startApp()
            }
        }

    }
    
    private func startApp() {
        self.present(self.mainController, animated: true)
    }
    
    private func setLayout() {
        [imgInstagram, lblAppcent].forEach { view.addSubview($0) }
        
        view.backgroundColor = .black
        imgInstagram.center = view.center
        
        NSLayoutConstraint.activate([
            lblAppcent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lblAppcent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            lblAppcent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            lblAppcent.heightAnchor.constraint(equalToConstant: view.frame.height/12)
        ])
    }
    
}
