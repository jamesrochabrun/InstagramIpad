//
//  PostViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel for a post displayed in a feed without user, comments info.
*/
struct PostViewModel {
        
    var id: UUID {
        UUID()
    }
    let content: FileContent
    
    static var userFeedPosts: [PostViewModel] {
        PostsStubData.userProfilePhotos.map { PostViewModel(content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
    }
    
    static var homeFeedPosts: [PostViewModel] {
        PostsStubData.homeFeedPhotos.map { PostViewModel(content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
    }
    
    static var searchFeedPlaceholderPosts: [PostViewModel] {
        PostsStubData.searchFeedPlaceholderPhotos.map { PostViewModel(content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
    }
}

extension PostViewModel: Equatable, Hashable {
    
    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        return
            lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension PostViewModel: ContentCollection {}
