//
//  ThirdViewController.swift
//  WeatherApp
//
//  Created by Ангеліна Семенченко on 26.03.2022.
//

import UIKit

class ThirdViewController: MainViewController {
    
    override var videoURL: URL? {
        return URL(string: urlDict["Ho Chi Minh"] ?? "")
    }
    
}
