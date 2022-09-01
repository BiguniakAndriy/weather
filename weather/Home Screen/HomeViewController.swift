//
//  ViewController.swift
//  weather
//
//  Created by Andriy Biguniak on 29.08.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - VARs
    
    private let viewModel = HomeViewModel()
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let table     = UITableView()
    private let button    = UIButton(type: .system)
    
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupData()
    }
    
    
    //MARK: - UI
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(nameLabel)
        self.view.addSubview(typeLabel)
        self.view.addSubview(table)
        self.view.addSubview(button)
        
        setupLabels()
        setupTable()
        setupButton()
    }
    
    // constraints
    private func setupConstraints() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.typeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.table.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        let standartHeight : CGFloat = 44
        
        NSLayoutConstraint.activate([
            
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -standartHeight*2),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.button.heightAnchor.constraint(equalToConstant: standartHeight),
            
            self.table.bottomAnchor.constraint(equalTo: self.button.topAnchor, constant: -standartHeight),
            self.table.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.table.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            self.table.heightAnchor.constraint(equalToConstant: standartHeight*5),
            
            self.typeLabel.bottomAnchor.constraint(equalTo: self.table.topAnchor,constant: -standartHeight*2),
            self.typeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.typeLabel.widthAnchor.constraint(equalTo: self.button.widthAnchor),
            self.typeLabel.heightAnchor.constraint(equalToConstant: standartHeight),
            
            self.nameLabel.bottomAnchor.constraint(equalTo: self.typeLabel.topAnchor),
            self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.nameLabel.heightAnchor.constraint(equalToConstant: standartHeight),
            
            
        ])
    }
    
    // controls
    private func setupLabels() {
        self.nameLabel.font = .systemFont(ofSize: 36, weight: .bold)
        self.nameLabel.textColor = .black
        self.nameLabel.numberOfLines = 1
        self.nameLabel.textAlignment = .center
        
        self.typeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        self.typeLabel.textColor = .systemGray
        self.typeLabel.numberOfLines = 1
        self.typeLabel.textAlignment = .center
    }
    
    private func setupButton() {
        self.button.backgroundColor = .systemBlue
        self.button.layer.cornerRadius = 5
        self.button.clipsToBounds = true
        self.button.setTitle("Search", for: .normal)
        self.button.setTitleColor(.white, for: .normal)
        self.button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        self.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupTable() {
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    
    // MARK: - ACTIONS

    @objc private func buttonPressed() {
        let vc = SelectionViewController()
        vc.callbackWithDataModel? = { [unowned self] dataModel in
            print("2 - \(dataModel)")
            self.viewModel.dataModel = dataModel
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - HELPERS
    
    private func setupData() {
        self.nameLabel.text = self.viewModel.dataModel?.city.name ?? "City name"
        self.typeLabel.text = self.viewModel.dataModel?.city.size.rawValue ?? "Size"
        self.table.isHidden = self.viewModel.dataModel == nil ? true : false
        self.table.reloadData()
        
        if self.viewModel.dataModel == nil { print("ERROR: where is my data ?") }
    }
    
} // class end


// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.setupCellWith(indexPath: indexPath)
    }
}

