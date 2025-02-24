//
//  HomeView.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel = HomeViewModel()
    
    @State private var showHistoryPresented: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Hey X... 👋")
                        .fontDesign(.rounded)
                        .foregroundStyle(Color.gray.opacity(0.8))
                    Text("Find your match")
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Button {
                    showHistoryPresented.toggle()
                } label: {
                    Text("History")
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            ZStack {
                if viewModel.matches.isEmpty {
                    Text("No more matches!")
                        .font(.title)
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.matches, id: \.id) { match in
                        
                        SwipeableCardView(match: match) { isAccepted in
                            if isAccepted {
                                print("✅ Accepted: \(match.name)")
                            } else {
                                print("❌ Rejected: \(match.name)")
                            }
                            removeTopMatch(match)
                        }
                        .environmentObject(viewModel)
                    } 
                }
            }
            
            Spacer()
        }
        .onAppear{
            
            viewModel.fetchMatches()
        }
        .sheet(isPresented: $showHistoryPresented) {
            HistoryView()
                .environmentObject(viewModel)
        }
    }
    
    private func removeTopMatch(_ match: MatchModel) {
        viewModel.matches.removeAll { $0.id == match.id }
    }
}

#Preview {
    HomeView()
}
