//
//  SelectionViewController.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import UIKit

class SelectionViewController : UIViewController {
    
    // MARK: - VARs
    
    private let cityPicker = UIPickerView()
    private let selectionButton = UIButton(type: .system)
    
    private let viewModel = SelectionViewModel()
    var callbackWithDataModel : ((DataModel?)->())?
    private let tempreratureSegmentedControl = UISegmentedControl(
        items: [ "Celsius", "Fahrenheit", "Kelvin"]
    )
    
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.cityPicker)
        self.view.addSubview(self.tempreratureSegmentedControl)
        self.view.addSubview(self.selectionButton)
        
        setupCityPicker()
        setupSelectionButton()
        setupTemperatureFormatSelection()
    }
    
    private func setupCityPicker() {
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
    }
    
    private func setupTemperatureFormatSelection() {
        self.tempreratureSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupSelectionButton() {
        self.selectionButton.backgroundColor = .systemBlue
        self.selectionButton.layer.cornerRadius = 5
        self.selectionButton.clipsToBounds = true
        self.selectionButton.setTitle("Get weather", for: .normal)
        self.selectionButton.setTitleColor(.white, for: .normal)
        self.selectionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        self.selectionButton.addTarget(self, action: #selector(selectionButtonPressed),
                                       for: .touchUpInside)
    }
    
    private func setupConstraints() {
        self.cityPicker.translatesAutoresizingMaskIntoConstraints = false
        self.tempreratureSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.selectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        let standartHeight : CGFloat = 44
        
        NSLayoutConstraint.activate([
            self.cityPicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.cityPicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,
                                                     constant: -standartHeight),
            self.cityPicker.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                   multiplier: 0.75),
            self.cityPicker.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                    multiplier: 0.25),
            
            self.tempreratureSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tempreratureSegmentedControl.topAnchor.constraint(equalTo: self.cityPicker.bottomAnchor,
                                                                   constant: standartHeight),
            self.tempreratureSegmentedControl.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                                     multiplier: 0.75),
            self.tempreratureSegmentedControl.heightAnchor.constraint(equalToConstant: standartHeight),
            
            self.selectionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectionButton.topAnchor.constraint(equalTo: self.tempreratureSegmentedControl.bottomAnchor,
                                                      constant: standartHeight*2),
            self.selectionButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.selectionButton.heightAnchor.constraint(equalToConstant: standartHeight),
        ])
    }
    
    
    // MARK: - ACTIONS

    @objc private func selectionButtonPressed() {
        Task {
            // fetch data
            guard let dataModel = await self.viewModel.fetchData(
                cityIndex: self.cityPicker.selectedRow(inComponent: 0),
                temperatureIndex: self.tempreratureSegmentedControl.selectedSegmentIndex)
            else { return }
            
            await MainActor.run {
                // pass data to HomeVC
                self.callbackWithDataModel?(dataModel)
                self.navigationController?.popViewController(animated: true)    
            }
        }
    }
    
} // class end


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension SelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.cities[row].name
    }

}
