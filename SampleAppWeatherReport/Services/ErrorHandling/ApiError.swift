//
//  Errorhandling.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation

enum ApiError : Error,Identifiable {
    
    var id: String { localizedDescription }
    case somethingWentWrong
    case noDataFound
    case noInternet
    case urlInvalid
    
    var errorDescription: String {
        switch self {
        case .urlInvalid:
            return "Invalid URL 👎👎👎"
        case .noInternet:
            return "Check your internet connectivity 🛜"
        case .noDataFound:
            return "Invalid response from server : Data is nil 😞"
        case .somethingWentWrong:
            return "something went wrong 😑"
        }
    }
    
}
