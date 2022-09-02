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
    private let standartHeight : CGFloat = 44
    
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let table     = UITableView()
    private let button    = UIButton(type: .system)
    
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(table)
        view.addSubview(button)
        
        setupLabels()
        setupTable()
        setupButton()
    }
    
    
    // MARK: - CONSTRAINTS
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        table.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -standartHeight*2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalToConstant: standartHeight),
            
            table.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -standartHeight),
            table.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            table.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            table.heightAnchor.constraint(equalToConstant: standartHeight*5),
            
            typeLabel.bottomAnchor.constraint(equalTo: table.topAnchor,constant: -standartHeight*2),
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeLabel.widthAnchor.constraint(equalTo: button.widthAnchor),
            typeLabel.heightAnchor.constraint(equalToConstant: standartHeight),
            
            nameLabel.bottomAnchor.constraint(equalTo: typeLabel.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            nameLabel.heightAnchor.constraint(equalToConstant: standartHeight),
        ])
    }
    
    
    // MARK: - CONTROLS
    
    private func setupLabels() {
        nameLabel.font = .systemFont(ofSize: 36, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .center
        
        typeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        typeLabel.textColor = .systemGray
        typeLabel.numberOfLines = 1
        typeLabel.textAlignment = .center
    }
    
    private func setupButton() {
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.addTarget(self, action: #selector(onSearchButtonPressed), for: .touchUpInside)
    }
    
    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    // MARK: - ACTIONS

    @objc private func onSearchButtonPressed() {
        let vc = SelectionViewController()
        vc.callbackWithDataModel = { [unowned self] dataModel in
            self.viewModel.data = dataModel
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - HELPERS
    
    private func setupData() {
       nameLabel.text = viewModel.data?.city.name ?? "City name"
       typeLabel.text = viewModel.data?.city.size.rawValue ?? "Size"
       table.isHidden = viewModel.data == nil ? true : false
       table.reloadData()
    }
    
} // class end


// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        return viewModel.setupCellWith(indexPath: indexPath, cell: cell)
    }
}

