//
//  ViewModel.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation
import Combine

final class ViewModel : ObservableObject {
    
    private init() {}
    
    static let shared = ViewModel()
    private let apiManger = ApiManager.shared
    private var cancellable = Set<AnyCancellable>()
    
    @Published var error : ApiError?
    @Published var displayData : [DisplayData] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    
    private var coordinates :CoordinateData? {
        
        didSet {
            
            guard let coor = coordinates,let lat = coor.lat,let long = coor.lon else {
                
                self.error = ApiError.somethingWentWrong
                return
            }
            
            self.fetchWeatherReport(lat,long)
            
        }
    }
    private var weatherReport :WeatherData? {
        
        didSet {
            guard let weatherRep = weatherReport, let report = weatherRep.weather,report.count > 0 else {
                
                DispatchQueue.main.async {
                    self.error = ApiError.somethingWentWrong
                }
                return
            }
            
            let cityName = weatherRep.name == nil ? ((coordinates?.name != searchText) ? searchText : coordinates?.name) : ((weatherRep.name != searchText) ? searchText : weatherRep.name )
            
            let displayData = DisplayData(cityName: cityName ?? searchText,
                                          icon: report[0].icon,
                                          temp: weatherRep.main?.temp ?? 0.0,
                                          weatherCondition: report[0].main ?? "")
            isLoading = false
            searchText = ""
            
            self.displayData.append(displayData)
            self.displayData.reverse()
            
        }
    }
    
    func getReport()  {
        
        self.isLoading = true
        fetchCoordinate(searchText)
    }
    
    private func fetchCoordinate(_ cityName:String) {
        
        apiManger.fetchData(.cityLatLong(cityName))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case.finished : break
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] (data: [CoordinateData])  in
                
                if data.count > 0 {
                    self?.coordinates = data[0]
                    
                } else {
                    self?.error = .noDataFound
                    
                }
            }.store(in: &cancellable)
        
    }
    
    private func fetchWeatherReport(_ lat:Double ,_ long:Double) {
        
        apiManger.fetchData(.weatherReport(lat, long))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case.finished : break
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] (weather: WeatherData) in
                
                self?.weatherReport = weather
            }.store(in: &cancellable)
        
    }
}
