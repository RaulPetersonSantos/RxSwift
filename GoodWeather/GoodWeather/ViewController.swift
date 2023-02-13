//
//  ViewController.swift
//  GoodWeather
//
//  Created by raul.santos on 01/02/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map{ self.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
        
    }

    
    private func fetchWeather(by city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            
            return
        }
        
        let resource = Resource<WeaterResult>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchError { error in
                print(error.localizedDescription)
                return Observable.just(WeaterResult.empty)
            }.asDriver(onErrorJustReturn: WeaterResult.empty)
//        let search =  URLRequest.load(resource: resource)
//            .observe(on: MainScheduler.instance)
//            .asDriver(onErrorJustReturn: WeaterResult.empty)
//
        search.map{ "\($0.main.temp) ℃"}
            .drive(self.temperaturaLabel.rx.text)
            .disposed(by: disposeBag)

        search.map{ "\($0.main.humidity)  💧"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
          
        
    }

    private func displayWeather(_ weather: Weather?) {
        
        if let weather = weather {
            self.temperaturaLabel.text = "\(weather.temp) ℃"
            self.humidityLabel.text = "\(weather.humidity) 💧"
        } else {
            self.temperaturaLabel.text = "🙈"
            self.humidityLabel.text = "⛔︎"
        }
        
    }
    
}

