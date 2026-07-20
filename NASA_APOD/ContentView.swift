//
//  ContentView.swift
//  NASA_APOD
//
//  Created by Phanit Pollavith on 7/16/26.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject private var viewModel = APODViewModel()
  
    var body: some View {
      
      NavigationStack {
        ScrollView {
          if viewModel.isLoading {
            ProgressView("Loading today's picture...")
          } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
              .foregroundStyle(.yellow)
          }
          else if let apod = viewModel.apod {
            VStack(alignment: .leading) {
              AsyncImage(url: URL(string: apod.url)) { image in
                image
                  .resizable()
                  .scaledToFit()
                  .clipShape(RoundedRectangle(cornerRadius: 12))
              } placeholder: {
                ProgressView()
              }
              
              Text(apod.title)
                .font(.title2.bold())
              
              Text(apod.date)
                .font(.caption)
                .foregroundStyle(.secondary)
              
              Text(apod.explanation)
                .font(.body)
            }
            .padding()
          }
        }
        .navigationTitle("Picture of the Day")
      }
      .task {
        await viewModel.loadAPOD()
      }
    }
}

#Preview {
    ContentView()
}
