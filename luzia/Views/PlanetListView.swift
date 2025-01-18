//
//  PlanetListView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftData
import SwiftUI

struct PlanetListView: View {
    @StateObject private var viewModel: InfiniteListViewModel<PlanetRepositoryManager>
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    
    init(modelContext: ModelContext) {
        let remoteRepository = PlanetRepositoryRemote()
        let localRepository = PlanetRepositoryPersisted(modelContext: modelContext)
        let repositoryManager = PlanetRepositoryManager(remoteRepository: remoteRepository,
                                                        localRepository: localRepository)
        
        _viewModel = StateObject(wrappedValue: InfiniteListViewModel(attribute: .planets, repository: repositoryManager))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.items) { planet in
                    PlanetRowView(planet: planet)
                        .onAppear {
                            Task { await viewModel.requestMoreItemsIfNeeded(item: planet) }
                        }
                    
                    if planet == viewModel.items.last {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    }
                }
                
                if viewModel.items.isEmpty && !viewModel.isLoading {
                    PlanetEmptyView { Task { try await viewModel.requestInitialSetOfItems() } }
                        .padding(.top, 60)
                }
            }
            .navigationTitle("Star Wars Planets")
            .onAppear {
                Task { try await viewModel.requestInitialSetOfItems() }
            }
            .refreshable {
                if networkMonitor.isConnected {
                    Task { try await viewModel.refreshItems() }
                }
            }
            .overlay {
                if viewModel.isRefreshing {
                    LoadingView()
                }
            }
            .toast(isPresented: .constant(!networkMonitor.isConnected),
                   message: "Your network is unavailable. Check your data or wifi connection")
        }
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: Planet.self)
    PlanetListView(modelContext: ModelContext(modelContainer))
}
