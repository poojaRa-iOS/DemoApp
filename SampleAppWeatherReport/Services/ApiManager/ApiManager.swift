//
//  ApiManager.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import Foundation
import Combine


final class ApiManager : ApiServices {
    
    static let shared = ApiManager()
    private init(){}
    
    func fetchData<T>(_ api: ApiType) -> AnyPublisher<T, ApiError> where T : Decodable {
        guard let url = API.shared.getRequestUrl(api) else {
            
            return Fail(error: ApiError.urlInvalid).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                
                if let apiError = error as? ApiError {
                    return apiError
                } else if error is DecodingError {
                    return ApiError.noDataFound
                } else {
                    return ApiError.somethingWentWrong
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}
