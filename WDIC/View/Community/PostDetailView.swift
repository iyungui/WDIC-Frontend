//
//  PostDetailView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    @State private var liked: Bool = false
    @State private var showingModal: Bool = false
    @State private var selectedImage: String = ""
    @State private var isFullScreen: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                postProfile
                postContent
                postTools
                Divider().padding(.horizontal)
            }
        }
        .sheet(isPresented: $showingModal, content: {
            EmptyView()
        })
        .fullScreenCover(isPresented: $isFullScreen) {
            FullScreenImageView(imageName: selectedImage)
        }
        .navigationTitle(Text("상세"))
        .navigationBarTitleDisplayMode(.inline)
    }
    private var postProfile: some View {
        Group {
            HStack(spacing: 15) {
                Image("logo_3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1))
                
                VStack(alignment: .leading) {
                    Text((post.username))
                        .font(.footnote)
                        .foregroundColor(.black)
                    Text(post.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
    private var postContent: some View {
        VStack {
            Text(post.content)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(["image1", "image2", "image3"], id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.selectedImage = imageName
                                self.isFullScreen = true
                            }

                    }
                }
                .padding()
            }

            Text(post.content)
                .padding(.horizontal)
        }
    }
    private var postTools: some View {
        HStack(spacing: 20) {
            Button(action: {
                liked.toggle()
            }) {
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(post.likes)")
                }
                .foregroundColor(liked ? Color.Color6 : Color.Color7)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                self.showingModal = true
            }) {
                HStack {
                    Image(systemName: "text.bubble.fill")
                    Text("\(post.likes)")
                }
            }
            .foregroundColor(Color.Color7)
        }
        .padding()
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Post instance
        let samplePost = Post(id: 1, username: "SampleUser", date: "2023-01-01", content: "Sample content", likes: 100, comments: 10)
        PostDetailView(post: samplePost) // Use the sample Post as a parameter
    }
}
