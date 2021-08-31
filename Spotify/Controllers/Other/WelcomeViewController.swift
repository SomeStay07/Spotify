//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Views
    private let signInButton = UIButton()
        .decorated(with: .title("Sign In with Spotify"))
        .decorated(with: .titleColor(.blue, .normal))
        .decorated(with: .backgroundColor(.white))
    
    private let alert = UIAlertController(
        title         : "Ooops",
        message       : "Something went wrong with signing in.",
        preferredStyle: .alert
    )

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        embedViews()
        setupAppearance()
        setupBehaviour()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signInButton.frame = CGRect(
            x     : 20,
            y     : view.height - 60 - view.safeAreaInsets.bottom,
            width : view.width - 40,
            height: 50
        )
    }
    
    // MARK: - Handlers
    @objc func didTapSignIn() {
        let viewController = AuthViewController()
        viewController.completionHandler = { [weak self] success in
            self?.handleSignIn(success: success)
        }
        
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension WelcomeViewController {
    
    // MARK: - Embed views
    func embedViews() {
        view.addSubview(signInButton)
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        title = "Spotify"
        view.backgroundColor = .systemGreen
    }
    
    // MARK: - Setup behaviour
    func setupBehaviour() {
        signInButton.addTarget(
            self,
            action: #selector(didTapSignIn),
            for: .touchUpInside
        )
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    }
    
    // MARK: - Handle signIn
    func handleSignIn(success: Bool) {
        guard success else {
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
