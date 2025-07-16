//
//  DisplayData.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation

struct DisplayData : Identifiable {
    let id =  UUID()
    let cityName:String
    let icon: String?
    let temp : Double
    let weatherCondition: String
    var imageURL :URL? {
        return API.shared.getRequestUrl(.weatherIcon(icon ?? ""))
    }
}


