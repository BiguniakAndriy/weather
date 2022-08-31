//
//  ViewController.swift
//  weather
//
//  Created by Andriy Biguniak on 29.08.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - VARs
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let table     = UITableView()
    private let button    = UIButton(type: .system)
    private var data      : WeatherModel?
    
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupConstraints()
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
        setupLabelWith(label: self.nameLabel,
                       font: .systemFont(ofSize: 36, weight: .bold),
                       textColor: .black
        )
        
        setupLabelWith(label: self.typeLabel,
                       font: .systemFont(ofSize: 17, weight: .regular),
                       textColor: .systemGray
        )
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
    
    // data
    private func setupData() {
        self.nameLabel.text = self.data?.city.name ?? "City name"
        self.typeLabel.text = self.data?.city.size.rawValue ?? "Size"
        self.table.isHidden = self.data == nil ? true : false
    }
    
    // button pressed
    @objc private func buttonPressed() {
        let vc = SelectionViewController()
        vc.callbackWithData? = { dataModel in
                self.data = dataModel
                self.setupData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - HELPERS
    private func setupLabelWith(label: UILabel, font: UIFont, textColor: UIColor) {
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 1
        label.textAlignment = .center
    }
    
} // class end


// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage(systemName: "cloud.sun.bolt.fill")
            cell.textLabel?.text = "Description - \(self.data?.weather.description ?? "")"
        case 1:
            cell.imageView?.image = UIImage(systemName: "thermometer")
            cell.textLabel?.text = "Temperature - \(self.data?.weather.temp ?? 0)"
        case 2:
            cell.imageView?.image = UIImage(systemName: "thermometer.sun")
            cell.textLabel?.text = "Fells like - \(self.data?.weather.tempFeelsLike ?? 0)"
        case 3:
            cell.imageView?.image = UIImage(systemName: "humidity")
            cell.textLabel?.text = "Humidity - \(self.data?.weather.humidity ?? 0)"
        case 4:
            cell.imageView?.image = UIImage(systemName: "rectangle.compress.vertical")
            cell.textLabel?.text = "Preassure - \(self.data?.weather.pressure ?? 0)"
        default:
            cell.imageView?.image = UIImage(systemName: "wind")
            cell.textLabel?.text = "Wind speed - \(self.data?.weather.windSpeed ?? 0)"
        }
        
        return cell
    }
}

