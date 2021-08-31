//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Тимур Чеберда on 03.04.2021.
//

import SDWebImage
import UIKit

final class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        
        return tableView
    }()
    
    private let errorLabel = UILabel(frame: .zero)
        .decorated(with: .text("Failed to get profile"))
        .decorated(with: .textColor(.secondaryLabel))
        .decorated(with: .isHidden(true))
        .decorated(with: .sizeToFit())
    
    
    private lazy var headerView = UIView(
        frame: CGRect(
            x     : 0,
            y     : 0,
            width : view.width,
            height: view.width/1.5
        )
    )
    
    private lazy var imageSize: CGFloat = headerView.height / 2
    
    private lazy var imageView = UIImageView(
        frame: CGRect(
            x     : 0,
            y     : 0,
            width : imageSize,
            height: imageSize
        )
    )
    
    // MARK: - Data
    private var models = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedViews()
        setupAppearance()
        fetchProfile()
        setupBehaviour()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

private extension ProfileViewController {
    
    // MARK: - Fetch profile
    func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.errorLabel.isHidden = false
                }
            }
        }
    }
    
    // MARK: - Update UI
    func updateUI(with model: UserProfile) {
        tableView.isHidden  = false
        errorLabel.isHidden = true
        
        models.append("Full Name: \(model.displayName)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        
        createTableHeader(with: model.images.first?.url)
        
        tableView.reloadData()
    }
    
    // MARK: - Embed views
    func embedViews() {
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        
        headerView.addSubview(imageView)
        
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - Setup Appearance
    func setupAppearance() {
        title = "Profile"
        view.backgroundColor = .systemBackground

        imageView.center              = headerView.center
        imageView.contentMode         = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius  = imageSize / 2
        
        errorLabel.center = view.center
    }
    
    // MARK: - Setup behaviour
    func setupBehaviour() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createTableHeader(with string: String?) {
        guard let urlString = string,
              let url = URL(string: urlString)
        else { return }
        

        imageView.sd_setImage(with: url, completed: nil)
    }
}
