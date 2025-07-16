//
//  Api.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation

final class API {
    
    static let shared = API()
    private init(){}
    private let apiId = "&appid=2fdc60b8f893b261772b44bb960f9346"
    private let apiBaseUrl = "https://api.openweathermap.org/"
    private let imageBaseUrl = "https://openweathermap.org/img/wn/"
    
    func getRequestUrl(_ api:ApiType)-> URL? {
        
        switch api {
            
        case .cityLatLong(let city):
            
            return URL(string: apiBaseUrl + "geo/1.0/direct?q=" + city + apiId)
            
        case .weatherReport(let lat,let long):
            
            return URL(string: apiBaseUrl + "data/2.5/weather?" + "lat=" + String(lat) + "&lon=" + String(long) + apiId + "&units=metric")
            
        case .weatherIcon(let param):
            
            return URL(string: imageBaseUrl + param + ".png") ??  URL(string: imageBaseUrl + param + ".jpeg")
        }
    }
    
}

enum ApiType {
    
    case cityLatLong(_ param:String)
    case weatherReport(_ lat:Double,_ long:Double)
    case weatherIcon(_ param:String)
}
