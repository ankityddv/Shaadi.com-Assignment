//
//  HomeView.swift
//  ShaadiComXAnkit
//
//  Created by Ankit Yadav on 24/02/25.
//

import SwiftUI


struct SwipeableCardView: View {
    
    let match: MatchModel
    let onSwipe: (Bool) -> Void
    
    @State private var offset: CGSize = .zero
    @State private var opacity: Double = 1.0
    
    private let cardWidth:CGFloat = UIScreen.main.bounds.width * 0.9
    private let cardHeight: CGFloat = 550
    
    var body: some View {
        
        ZStack {
            
            AsyncImage(url: URL(string: match.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                        .cornerRadius(20)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack {
                
                Spacer()
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.pink.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 150)
            }
            .frame(width: cardWidth, height: cardHeight)
            .cornerRadius(20)
            
            VStack(spacing: 10) {
                
                Spacer()
                
                HStack {
                    
                    Text(match.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                HStack {
                    
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                    Text("Nearby")
                    
                    Spacer()
                }
                .foregroundStyle(Color.white)
            }
            .padding([.bottom, .leading], 20)
        }
        .frame(width: cardWidth, height: cardHeight)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.gray.opacity(0.06), radius: 4)
        .overlay(content: {
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.red.opacity(0.8), Color.white.opacity(1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(width: 45, height: 45)

                        Text("❌")
                            .font(.system(size: 20))
                    }
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.gray.opacity(0.1), radius: 5)
                    .onTapGesture {
                        withAnimation {
                            swipeCard(right: false)
                        }
                    }
                    
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.green.opacity(0.8), Color.white.opacity(1)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(width: 60, height: 60)

                        Text("💖")
                            .font(.system(size: 30))
                    }
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.gray.opacity(0.1), radius: 5)
                    .onTapGesture {
                        swipeCard(right: true)
                    }
                }
                .offset(x: -20, y: 15)
            }
        })
        .offset(offset)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        swipeCard(right: true) // Right swipe (Accepted)
                    } else if offset.width < -100 {
                        swipeCard(right: false) // Left swipe (Rejected)
                    } else {
                        resetCardPosition()
                    }
                }
        )
        .opacity(opacity)
    }
    
    private func swipeCard(right: Bool) {
        withAnimation(.easeOut(duration: 0.3)) {
            offset = CGSize(width: right ? 500 : -500, height: 0)
            opacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onSwipe(right)
        }
    }
    
    private func resetCardPosition() {
        withAnimation(.spring()) {
            offset = .zero
        }
    }
}


struct HomeView: View {
    
    @State private var matches: [MatchModel] = [
        MatchModel(from: UserResponse(name: Name(first: "Emma", last: "Watson"), picture: Picture(large: "https://randomuser.me/api/portraits/women/1.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Chris", last: "Evans"), picture: Picture(large: "https://randomuser.me/api/portraits/men/2.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Scarlett", last: "Johansson"), picture: Picture(large: "https://randomuser.me/api/portraits/women/3.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Tom", last: "Holland"), picture: Picture(large: "https://randomuser.me/api/portraits/men/4.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Zendaya", last: "Coleman"), picture: Picture(large: "https://randomuser.me/api/portraits/women/5.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Henry", last: "Cavill"), picture: Picture(large: "https://randomuser.me/api/portraits/men/6.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Gal", last: "Gadot"), picture: Picture(large: "https://randomuser.me/api/portraits/women/7.jpg"), login: Login(uuid: UUID().uuidString))),
        
        MatchModel(from: UserResponse(name: Name(first: "Ryan", last: "Reynolds"), picture: Picture(large: "https://randomuser.me/api/portraits/men/8.jpg"), login: Login(uuid: UUID().uuidString)))
    ]
    
    
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
            }
            .padding(.horizontal, 24)
            
            Spacer()
            
            ZStack {
                if matches.isEmpty {
                    Text("No more matches!")
                        .font(.title)
                        .foregroundColor(.gray)
                } else {
                    ForEach(matches, id: \.id) { match in
                        
                        SwipeableCardView(match: match) { isAccepted in
                            if isAccepted {
                                print("✅ Accepted: \(match.name)")
                            } else {
                                print("❌ Rejected: \(match.name)")
                            }
                            removeTopMatch(match)
                        }
                    }
                    
                }
            }
            
            Spacer()
        }
    }
    
    private func removeTopMatch(_ match: MatchModel) {
        matches.removeAll { $0.id == match.id }
    }
}

#Preview {
    HomeView()
}
