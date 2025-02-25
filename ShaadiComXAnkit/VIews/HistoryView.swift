//
//  HistoryView.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import SwiftUI

enum MatchCardType {
    case swipable
    case history
}

struct HistoryView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @ObservedObject private var viewModel: HistoryViewModel = HistoryViewModel()
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                Text("Matches History")
                    .fontDesign(.rounded)
                    .font(.title2)
                    .padding(.vertical, 16)
                
                Spacer()
                
                ForEach(viewModel.history, id: \.id) { match in
                    
                    SwipeableCardView(match: match, cardType: .history){_ in}
                    .environmentObject(homeViewModel)
                }
            }
            .onAppear {
                viewModel.fetchMatches(storage: CoreDataManager())
            }
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(HomeViewModel())
}
