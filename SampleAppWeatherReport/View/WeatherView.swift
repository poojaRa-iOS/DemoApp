//
//  WeatherView.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import SwiftUI

struct WeatherView: View {
    
    let displayData : DisplayData
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(displayData.cityName)
                .font(.title)
                .fontWeight(.bold)
            
            Text(displayData.weatherCondition)
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack {
                
                Text(String(displayData.temp)).font(.headline)
                Text("℃").font(.headline)
                AsyncImage(url: displayData.imageURL) { image in
                    image.resizable().scaledToFit().frame(width: 50,height: 50)
                } placeholder: {
                    Image(systemName: "thermometer.high")
                }
                
            }//:END OF HSTACK
            
        }//:END OF VSTACK
    }
}

#Preview {
    WeatherView(displayData: DisplayData(cityName: "Mumbai", icon: "https://openweathermap.org/img/wn/03d.png", temp: 17.0, weatherCondition: "Cloud"))
}
