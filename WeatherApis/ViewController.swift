//
//  ViewController.swift
//  WeatherApis
//
//  Created by tantest on 30/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityNameTextField.rx.controlEvent(.editingDidEnd).map{ self.cityNameTextField.text }.subscribe(onNext: {city in
            print("----------")
            print(city)
            if let city = city {
                if city.isEmpty {
                    self.displayWeather(weather: nil)
                } else {
                    self.fetchApis(city: city)
                }
            }
        }).disposed(by: bag)

    }
    
    
    private func fetchApis(city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL.urlWeatherApis(city: cityEncoded)
        else { return }
        
        let resources = Resource<WeatherModels>(url: url)
        
        
        let search  = URLRequest.load(resource: resources).observe(on: MainScheduler.instance).catchAndReturn(WeatherModels.empty).share(replay: 1).observe(on: MainScheduler.instance)
        
        search.map{ "\(String(describing: $0.main?.temp!))" }.bind(to: self.tempatureLabel.rx.text).disposed(by: bag)
        
        search.map{ "\(String(describing: $0.main?.humidity!))" }.bind(to: self.humidityLabel.rx.text).disposed(by: bag)
        
        search.map{ $0.name }.bind(to: self.cityNameTextField.rx.text).disposed(by: bag)
        
        
        search.map{ $0.name }.bind(to: self.cityLabel.rx.text).disposed(by: bag)
    }
    
    
    private func displayWeather(weather: WeatherModels?) {
        if let data = weather?.main  {
            tempatureLabel.text = "\(data.temp!)"
            humidityLabel.text = "\(data.humidity!)"
            cityLabel.text = weather?.name
        }
    }
}

