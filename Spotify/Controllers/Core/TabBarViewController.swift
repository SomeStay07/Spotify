//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Views
    private let homeViewController    = HomeViewController()
    private let searchViewController  = SearchViewController()
    private let libraryViewController = LibraryViewController()
    
    private lazy var homeNavController    = UINavigationController(
        rootViewController: homeViewController
    )
    
    private lazy var searchNavController  = UINavigationController(
        rootViewController: searchViewController
    )
    
    private lazy var libraryNavController = UINavigationController(
        rootViewController: libraryViewController
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        setupAppearance()
        setupTabBar()
    }
    
    // MARK: - Setup appearance
    private func setupAppearance() {
        homeViewController.title = "Browse"
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        
        homeNavController.navigationBar.tintColor = .label
        homeNavController.navigationBar.prefersLargeTitles = true
        
        searchViewController.title = "Search"
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        
        searchNavController.navigationBar.prefersLargeTitles = true
        searchNavController.navigationBar.tintColor = .label
        
        libraryViewController.title = "Library"
        libraryViewController.navigationItem.largeTitleDisplayMode = .always
        
        libraryNavController.navigationBar.prefersLargeTitles = true
        libraryNavController.navigationBar.tintColor = .label
    }
    
    // MARK: - Setup TabBar
    private func setupTabBar() {
        homeNavController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1
        )
        
        searchNavController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 2
        )
        
        libraryNavController.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "music.note.list"),
            tag: 3
        )
                
        setViewControllers(
            [ homeNavController,
              searchNavController,
              libraryNavController
            ],
            
            animated: false
        )
    }
}
