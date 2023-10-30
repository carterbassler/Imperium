//
//  UploadPostView.swift
//  Imperium
//
//  Created by Carter Bassler on 10/11/23.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex : Int
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    clearPost()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPost()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing : 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width : 100, height : 100)
                        .clipped()
                }
                
                TextField("Enter your caption...", text : $caption, axis : .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection :
                        $viewModel.selectedImage)
    }
    
    func clearPost() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
