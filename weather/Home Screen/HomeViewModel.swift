//
//  HomeViewModel.swift
//  weather
//
//  Created by Andriy Biguniak on 01.09.2022.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var dataModel : DataModel?
    
    
    // MARK: - SETUP CELL
    
    func setupCellWith(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage(systemName: "cloud.sun.bolt.fill")
            cell.textLabel?.text = "Description - \(self.dataModel?.weather.description ?? "")"
        case 1:
            cell.imageView?.image = UIImage(systemName: "thermometer")
            cell.textLabel?.text = "Temperature - " + (self.dataModel?.getTemperature(mainTemp: true) ?? "???")
        case 2:
            cell.imageView?.image = UIImage(systemName: "thermometer.sun")
            cell.textLabel?.text = "Fells like - " + (self.dataModel?.getTemperature(mainTemp: false) ?? "???")
        case 3:
            cell.imageView?.image = UIImage(systemName: "humidity")
            cell.textLabel?.text = "Humidity - \(self.dataModel?.weather.humidity ?? 0)"
        case 4:
            cell.imageView?.image = UIImage(systemName: "rectangle.compress.vertical")
            cell.textLabel?.text = "Preassure - \(self.dataModel?.weather.pressure ?? 0)"
        default:
            cell.imageView?.image = UIImage(systemName: "wind")
            cell.textLabel?.text = "Wind speed - \(self.dataModel?.weather.windSpeed ?? 0)"
        }
        
        return cell
    }
    
    
}
