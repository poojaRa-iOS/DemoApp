//
//  ApiServices.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation
import Combine

protocol ApiServices {
        func fetchData<T:Decodable>(_ api:ApiType) -> AnyPublisher<T,ApiError>
}

