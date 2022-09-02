//
//  HomeViewModel.swift
//  weather
//
//  Created by Andriy Biguniak on 01.09.2022.
//

import UIKit

class HomeViewModel {
    
    var data : DataModel?
    
    // MARK: - SETUP CELL
    
    func setupCellWith(indexPath: IndexPath, cell: UITableViewCell) -> UITableViewCell {
        guard let data = data else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage(systemName: "cloud.sun.bolt.fill")
            cell.textLabel?.text = data.weather.description.uppercased()
        case 1:
            cell.imageView?.image = UIImage(systemName: "thermometer")
            cell.textLabel?.text = "Temperature - " + (data.getTemperature(mainTemp: true) )
        case 2:
            cell.imageView?.image = UIImage(systemName: "thermometer.sun")
            cell.textLabel?.text = "Fells like - " + (data.getTemperature(mainTemp: false) )
        case 3:
            cell.imageView?.image = UIImage(systemName: "humidity")
            cell.textLabel?.text = "Humidity - \(data.weather.humidity)"
        case 4:
            cell.imageView?.image = UIImage(systemName: "rectangle.compress.vertical")
            cell.textLabel?.text = "Preassure - \(data.weather.pressure)"
        default:
            cell.imageView?.image = UIImage(systemName: "wind")
            cell.textLabel?.text = "Wind speed - \(data.weather.windSpeed)"
        }
        return cell
    }
}
