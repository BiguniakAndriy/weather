//
//  SelectionViewController.swift
//  TestProject_Weather
//
//  Created by Andriy Biguniak on 02.08.2022.
//

import UIKit

class SelectionViewController : UIViewController {
    
    // MARK: - VARs
    var callbackWithData : ((WeatherModel)->())?
    private var cities = CityModel.cities
    private let cityPicker = UIPickerView()
    private let selectionButton = UIButton(type: .system)

    private let temperatureFormatSelection = UISegmentedControl(
        items: [ "Celsius", "Fahrenheit", "Kelvin"]
    )
    
    private let yesterdayDate : Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    
    
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
        self.view.addSubview(self.temperatureFormatSelection)
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
        self.temperatureFormatSelection.selectedSegmentIndex = 0
    }
    
    private func setupSelectionButton() {
        self.selectionButton.backgroundColor = .systemBlue
        self.selectionButton.layer.cornerRadius = 5
        self.selectionButton.clipsToBounds = true
        self.selectionButton.setTitle("Get weather", for: .normal)
        self.selectionButton.setTitleColor(.white, for: .normal)
        self.selectionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        self.selectionButton.addTarget(self, action: #selector(selectionButtonPressed), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        self.cityPicker.translatesAutoresizingMaskIntoConstraints = false
        self.temperatureFormatSelection.translatesAutoresizingMaskIntoConstraints = false
        self.selectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        let standartHeight : CGFloat = 44
        
        NSLayoutConstraint.activate([
            self.cityPicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.cityPicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -standartHeight),
            self.cityPicker.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.cityPicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25),
            
            self.temperatureFormatSelection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.temperatureFormatSelection.topAnchor.constraint(equalTo: self.cityPicker.bottomAnchor, constant: standartHeight),
            self.temperatureFormatSelection.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
            self.temperatureFormatSelection.heightAnchor.constraint(equalToConstant: standartHeight),
            
            self.selectionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectionButton.topAnchor.constraint(equalTo: self.temperatureFormatSelection.bottomAnchor, constant: standartHeight*2),
            self.selectionButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.selectionButton.heightAnchor.constraint(equalToConstant: standartHeight),
        ])
    }
    
    
    // MARK: - ACTIONS
    @objc private func selectionButtonPressed() async {
        
        //get city
        let city = self.cities[self.cityPicker.selectedRow(inComponent: 0)]
        
        //get web weather model
        guard let webWeatherModel = await NetworkManager.shared.getWeather(cityName: city.name)
        else {
            print("ERROR: Can`t get weather")
            return
        }
        
        // create weather model
        let weather = PresentationWeatherModel(weatherFromWeb: webWeatherModel)
        
        // create data model
        let dataModel = WeatherModel(
            city: city,
            weather: weather,
            temperatureFormat: self.checkTemperatureFormat()
        )
        
        self.callbackWithData?(dataModel)
    }
    
    
    // MARK: - HELPERS
    private func checkTemperatureFormat() -> TemperatureFormat {
        switch self.temperatureFormatSelection.selectedSegmentIndex {
        case 0:
            return .celsius
        case 1:
            return .fahrenheit
        default:
            return .kelvin
        }
    }
    
} // class end


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension SelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row].name
    }

}
