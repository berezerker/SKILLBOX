
import Foundation
import Alamofire
 
protocol AlamofireWeathersLoaderDelegate{
    func loaded(weathers: [Weather])
}

class AlamofireWeathersLoader{
    
    var delegate: AlamofireWeathersLoaderDelegate?
    func loadWeathers(completion: @escaping ([Weather]) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.77&lon=37.59&exclude=hourly&appid=2401cd0d12f17a5c22f2fb0e87cdf554&lang=ru&units=metric")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                if let jsonDict = json as? NSDictionary{
                    var weathers: [Weather] = []
                    if let trailingDaysJson = jsonDict["daily"] as? [NSDictionary]{
                        for v in trailingDaysJson{
                            if let weather = Weather(data: v){
                                weathers.append(weather)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.loaded(weathers: weathers)
                    }
                    }
                }
            }
        task.resume()
    }
}
