

import UIKit
import Alamofire


class AlamofireViewController: UIViewController {
    
    var loadingResponses: [String: UIImage] = [:]

    @IBOutlet weak var currentDescription: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tempFeelsLabel: UILabel!
    @IBOutlet weak var hourlyWeather: UICollectionView!
    var loader = WeathersLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.AlamofireLoadWeathers { current, daily in
            PersistanceForecast.shared.current = current
            PersistanceForecast.shared.daily = daily
            self.tableView.reloadData()
            self.hourlyWeather.reloadData()
        }
        if PersistanceForecast.shared.current != nil{
        self.currentDescription.text = PersistanceForecast.shared.current!.current!.weather[0]!.description
        self.currentTemp.text = "\(PersistanceForecast.shared.current!.current!.temp!)"
        self.tempMinLabel.text = "\(self.minTemp(current: PersistanceForecast.shared.current!))"
        self.tempMaxLabel.text = "\(self.maxTemp(current: PersistanceForecast.shared.current!))"
        self.currentImage.loadImageWithName(name: PersistanceForecast.shared.current!.current!.weather[0]!.icon!)
        self.currentImage.contentMode = .scaleAspectFill
        self.tempFeelsLabel.text = "\(PersistanceForecast.shared.current!.current!.feels_like!)"
        }
    }
    
    func minTemp(current: Current) -> Double{
        var min = 1000.0
        for v in current.hourly!{
            if v.temp! < min{
                min = v.temp!
            }
        }
        return min
    }
    
    func maxTemp(current: Current) -> Double{
        var max = -1000.0
        for v in current.hourly!{
            if v.temp! > max{
                max = v.temp!
            }
        }
        return max
    }
    

    
}

extension AlamofireViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let daily = PersistanceForecast.shared.daily{
        let leftWeathers = Array(daily.daily!.dropFirst(1))
        return leftWeathers.count
        }
        else{
        return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        if let daily = PersistanceForecast.shared.daily{
        let weather = daily.daily![indexPath.row + 1]
            cell.dayLabel.text = ("\(string(from: weather.dt!))")
        cell.imageWeather.loadImageWithName(name: weather.weather[0]!.icon!)
        cell.minTemperatureLabel.text = "\(weather.temp!.min!)"
        cell.maxTemperatureLabel.text = "\(weather.temp!.max!)"
        }
        return cell
    }
    

}

extension AlamofireViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCollectionViewCell", for: indexPath) as! HourCollectionViewCell
        if let current = PersistanceForecast.shared.current{
        let weather = current.hourly![indexPath.row]
            cell.temp_min.text = "\(weather.temp!)"
            cell.imageView.loadImageWithName(name: weather.weather[0]!.icon!)
        cell.hour.text = "\(indexPath.row)"
        }
        return cell
    }
    
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageWithName(name: String) {
        
        let urlString = "https://openweathermap.org/img/wn/\(name).png"
        
        image = nil
    
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }
                
            }
            dataTask.resume()
        }
    }
}


