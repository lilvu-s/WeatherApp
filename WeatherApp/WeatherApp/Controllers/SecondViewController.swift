//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by Ангеліна Семенченко on 25.03.2022.
//

import UIKit

class SecondViewController: MainViewController {
    
    override var videoURL: URL? {
        return URL(string: urlDict["New York"] ?? "")
    }
    
}
