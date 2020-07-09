

import Foundation
import Alamofire


class WeathersLoader{
    
    func AlamofireLoadWeathers(completion: @escaping (Current?, dailyForecast?) -> Void){
        var daily: dailyForecast?
        var currWeather: Current?
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.77&lon=37.59&exclude=hourly&appid=2401cd0d12f17a5c22f2fb0e87cdf554&lang=ru&units=metric")!
        let urlCurrent = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.77&lon=37.59&appid=2401cd0d12f17a5c22f2fb0e87cdf554&lang=ru&units=metric")!
        Alamofire.request(urlCurrent).responseData{ response in
            do{
                guard let data = response.data else {return}
                
                currWeather = try JSONDecoder().decode(Current.self, from: data)
            }catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(currWeather, daily)
            }
        }
        Alamofire.request(url).responseData { response in
            do{
                daily = try JSONDecoder().decode(dailyForecast.self, from: response.value!)
                print("DAILY LOADED")
            }catch{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(currWeather, daily)
            }
            }
            }
    
    }
