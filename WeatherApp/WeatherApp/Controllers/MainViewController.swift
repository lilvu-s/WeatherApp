//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ангеліна Семенченко on 24.03.2022.
//

import UIKit
import AVKit

class MainViewController: UIViewController {
    
    private var playerLooper: AVPlayerLooper?
    public var playerLayer = AVPlayerLayer()
    public var cityLabel = UILabel()
    public var dateLabel = UILabel()
    public var weatherDescription = UILabel()
    public var degrees = UILabel()
    public var weatherSymbol = UILabel()
    
    
    public var urlDict: Dictionary<String, String> {
        ["Rome": "https://cdn.dribbble.com/users/1970063/screenshots/16042967/media/0e6efa3f9990d6aea53b7453d89ffc00.mp4",
         "New York": "https://cdn.dribbble.com/users/1970063/screenshots/16113846/media/9b51fa2a6a6cffa50a43024faa02bfdc.mp4",
         "Ho Chi Minh": "https://cdn.dribbble.com/users/1970063/screenshots/15924060/media/f390126fd10f6756691dae6ceb37a178.mp4"]
    }
    
    public var videoURL: URL? {
        return URL(string: urlDict["Rome"] ?? "")
    }
    
    private lazy var videoPlayer: AVPlayerLayer = {
        let playerItem = AVPlayerItem(url: videoURL!)
        let player = AVQueuePlayer(playerItem: playerItem)
        
        playerLayer.player = player
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        
        return playerLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .citiesColor
        
        getWeather(city: "London")
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        videoPlayer.player?.play()
    }
    
    private func getWeather(city: String) {
        let apiKey = "&appid=e0c697ac4dfa8e153fa6d786f5934cdc"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }

        guard let data = data else { return }
    
            do {
                let weatherData = try JSONDecoder().decode(Parsing.self, from: data)
                let weatherTemp = weatherData.main.temp.rounded()
                let weatherDescription = weatherData.weather.first?.description
//                self.cityLabel.text = weatherData.name
                
                print(weatherData.name)
                
                weatherTemp <= 0 ?  print("Температура: -\(weatherTemp)°") :  print("Температура: +\(weatherTemp)°")
                
                print("Описание: \(weatherDescription)")
                print("Давление: \(weatherData.main.pressure) мм рт. ст.")
            
            } catch {
                print(error)
            }
        
        }.resume()
    }
    
    private func setupConstraints() {
        let array = [cityLabel, dateLabel, weatherDescription, degrees, weatherSymbol]
        let margins = view.layoutMarginsGuide
            for each in array {
                each.translatesAutoresizingMaskIntoConstraints = false
            }
        
        view.addSubview(cityLabel)
        view.addSubview(dateLabel)
        view.addSubview(weatherSymbol)
        view.addSubview(weatherDescription)
        view.addSubview(degrees)
        view.layer.addSublayer(playerLayer)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10)
        ])
        
        playerLayer.frame = view.bounds
    }
}

extension UIColor {
    class var citiesColor: UIColor {
        return UIColor(red: 195/255, green: 205/255 ,blue: 170/255 , alpha: 1)
    }
}
