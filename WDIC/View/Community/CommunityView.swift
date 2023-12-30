//
//  CommunityView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                HStack {
                    Text("提问 & 回答")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image("logo_1")
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .offset(y: -30)
            
            VStack(spacing: 0) {
                CommunityContentView()
                    .offset(y: 100)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Button action here
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.Color6)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    }
                    .padding(20)
                }
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CommunityContentView: View {
    let posts = [Post(id: 1, username: "User1", date: "2023-01-01", content: "This is the first post", likes: 10, comments: 2),
                 Post(id: 2, username: "User2", date: "2023-01-02", content: "This is the second post", likes: 20, comments: 5),
                 Post(id: 3, username: "User3", date: "2023-01-03", content: "This is the third post", likes: 20, comments: 5),
                 Post(id: 4, username: "User3", date: "2023-01-03", content: "This is the fourth post", likes: 20, comments: 5),
                 Post(id: 5, username: "User3", date: "2023-01-03", content: "This is the fifth post", likes: 20, comments: 5)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(posts) { post in
                    NavigationLink(destination: PostDetailView(post: post)) {
                        PostView(post: post)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(20)
            .padding(.bottom, 120)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
        .ignoresSafeArea()
    }
}

struct PostView: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
                HStack(spacing: 15) {
                    Image("logo_3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    
                    VStack(alignment: .leading) {
                        Text(post.username)
                            .font(.footnote)
                            .foregroundColor(.black)
                        Text(post.date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }

            Text(post.content)
                .foregroundColor(.black)
            
            HStack {
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                Image("image2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            HStack(spacing: 20) {
//                Button(action: {
//                    liked.toggle()
//                    // post.likes += 1
//                }) {
                    HStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("\(post.likes)")
                    }
                    .foregroundColor(Color.Color7)
//                }
//                .buttonStyle(PlainButtonStyle())
                
                HStack {
                    Image(systemName: "text.bubble.fill")
                    Text("\(post.likes)")
                }
                .foregroundColor(Color.Color7)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.Color7, lineWidth: 1)
        )
    }
}

struct Post: Identifiable {
    var id: Int
    var username: String
    var date: String
    var content: String
    var likes: Int
    var comments: Int
    // Add more fields as needed
}


#Preview {
    CommunityView()
}



