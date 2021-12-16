//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Vahit Emre TELLİER on 12.12.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
//    Api key is taken from Darksky.com
//    fileprivate means only accessible within this file
    fileprivate let apiKey = "4cb418bb54aa70da51742e395c441723"
//    let reqestURL = URL(string: "https://api.darksky.net/forecast/4cb418bb54aa70da51742e395c441723/41.0458902,28.960685")
    
//    for Lacation
    var locationManager = CLLocationManager()
    var userLongitude = Double()
    var userLatitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicator.startAnimating()
        
        
//        *********************************** - LOCATION - ************************************************
        
//        Artık konum yöneticisi bu swift dosyası oldu, aşağıdaki kod ile birlikte
        self.locationManager.delegate = self
        
//        uygulama açıldığında konum bilgisini paylaşmasını isteyecektir
        self.locationManager.requestWhenInUseAuthorization()
        
//        Is location service enabled on the device?
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
//            location information provided
            locationManager.startUpdatingLocation()
        }
//            **********************************************************************************************
        
        

//        1) Request & Session
//        2) Response & Data
//        3) Parsing & Json Serialization
        
        let baseURL = URL(string: "https://api.darksky.net/forecast/\(apiKey)/")
//        guard let means if it satisfies the condition
        guard let requestURL = URL(string: "41.0458902,28.960685", relativeTo: baseURL) else { return  }
        
//  ***************************************************************
//        when the internet connection rate is low in other words Json Object don't come synchronously, app will keep working. App is not waiting to come json object quickly for The Actions keep going.
        let request = URLRequest(url: requestURL)
//        an object that coordinates a group of related Data transfer / Bu ağa gidip veri transferi yapabilmek için UrlSession oluşturuldu.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        print("Control 1")
        
//        ****************** - Closure - *****************
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
//                  error?.localizedDescription => error description
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                if (data != nil){
                    print("Control 2")
                    
                    let jsonData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                    
//                    ASYNC
                    DispatchQueue.main.async {
                        if let weatherLocation = jsonData["timezone"] as? String{
                            self.locationLabel.text = weatherLocation
                        }
//                        print("Control 3")
                        
                        if let currentWeatherJson = jsonData["currently"] as? [String : Any]{
//                           print(currentWeatherJson)
                            if let tempature = currentWeatherJson["temperature"] as? Double  {
//                                print(tempature)
                                if let precipitation = currentWeatherJson["precipProbability"] as? Double{
                                    if let summary = currentWeatherJson["summary"] as? String{
                                        if let humidity = currentWeatherJson["humidity"] as? Double{
                                            if let img = currentWeatherJson["icon"] as? String{
                                                let weatherForecast = CurrentMood(tempature: tempature, precipitation: precipitation, summary: summary, humidity: humidity, img: img)
                                                let viewModel = CurrentMoodModal(data: weatherForecast)
                                                self.showView(model: viewModel)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
//                    print("Control 4")
                }
                
            }
        }
//        task started running
        task.resume()
//        print("Conrtol 5")
        
//        print("Codess keep working..")
//        ********************************************************
        

            
        
        
  /*
//        Internet connection may fail etc., so try-catch is created.

           let weatherData = try! Data(contentsOf: requestURL!)
            print(weatherData)
            
            let jsonData = try! JSONSerialization.jsonObject(with: weatherData, options: [])
            print(jsonData)

   */
        
     
//        manuel objects is created
/*        let weatherForecast = CurrentMood(tempature: 35.32, precipitation: 45.21, summary: "Sunny", humidity: 83.12, img: "rain")
        let viewModel = CurrentMoodModal(data: weatherForecast)
        showView(model: viewModel)*/
    }

//    for show on main screen
    func showView(model : CurrentMoodModal){
        temperatureLabel.text = model.tempature
        summaryLabel.text = model.summary
        precipitationLabel.text = model.precipitation
        humidityLabel.text = model.humidity
        weatherImage.image = model.img
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue = CLLocationCoordinate2D.init(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        userLongitude = locationValue.longitude
        userLatitude = locationValue.latitude
        
//        indicater stop
        indicator.stopAnimating()
    }
    
    

    

}

