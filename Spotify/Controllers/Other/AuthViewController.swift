//
//  AuthViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

import UIKit
import WebKit

final class AuthViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Views
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    // MARK: - Handlers
    public var completionHandler: ((Bool) -> Void)?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        embedView()
        setupAppearance()
        setupBehaviour()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
    
    func webView(
        _ webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation!
    ) {
        guard let url = webView.url else { return }
        
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value
        else {
            return
        }
        
        webView.isHidden = true
        
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }
}

private extension AuthViewController {
    
    // MARK: - Embed views
    func embedView() {
        view.addSubview(webView)
    }
    
    // MARK: - Setup appearance
    func setupAppearance() {
        title = "Sign In"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Setup behaviour
    func setupBehaviour() {
        webView.navigationDelegate = self
        
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
}
