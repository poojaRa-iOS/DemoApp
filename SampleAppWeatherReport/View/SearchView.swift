//
//  SerachView.swift
//  SampleAppWeatherReport
//
//  Created by Pooja Raghuwanshi on 15/07/25.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchText: String
    var body: some View {
        
        HStack(spacing: 5) {
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 20,height: 20)
            
            TextField("Enter city name", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            
        } //:END OF HSTACK
        .padding()
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
