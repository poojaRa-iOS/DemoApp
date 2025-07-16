//
//  ContentView.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel.shared
    @StateObject private var networkMonitor = NetworkMonitor.shared
    
    var body: some View {
        ZStack {
            
            VStack {
                
                // MARK: SEARCH
                SearchView(searchText: $viewModel.searchText)
                
                // MARK: GET WEATHER BUTTON
                if !(viewModel.searchText.isEmpty) {
                    
                    Button("Get Weather") {
                        if networkMonitor.isConnected {
                            viewModel.getReport()
                        } else {
                            viewModel.error = ApiError.noInternet
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.searchText.isEmpty)
                } //: END OF IF BLOCK
                
                
                // MARK: LOAD LISTVIEW
                if (viewModel.displayData.count > 0) {
                    
                    List(viewModel.displayData) { data in
                        WeatherView(displayData: data)
                    }
                    
                } else {
                    
                    Spacer()
                    Text("Enter city name and get weather report")
                    Spacer()
                    
                }
                
            } //: END OF VSTACK
            
            // MARK: PROGRESSVIEW
            if viewModel.isLoading  {
                
                ProgressView()
            }
            
        } //:ZSTACK
        .padding()
        .onChange(of: viewModel.error) {
            viewModel.isLoading = false
            viewModel.searchText = ""
        } //: END OF ONCHANGE
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.errorDescription), dismissButton: .default(Text("OK")))
        } //: END OF ALERT
    }
}

#Preview {
    ContentView()
}
