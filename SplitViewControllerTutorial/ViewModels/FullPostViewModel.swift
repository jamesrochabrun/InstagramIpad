//
//  FullPostViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/3/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// Stub data for grid collection content
struct PostsStubData {
    
    static var userProfilePhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "post\(i)")) // personal user photos
        }
        return photos.compactMap { $0 }
    }
    
    static var homeFeedPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "home\(i)")) // posts of followed users
        }
        return photos.compactMap { $0 }
    }
    
    static var searchFeedPlaceholderPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "search\(i)")) // random posts
        }
        return photos.compactMap { $0 }
    }
}

/// MARK:- Post kinds
enum FileContent: Hashable {
    
    var id: UUID { UUID() }
    
    case video(VideoPostViewModel)
    case photo(PhotoPostViewModel)
    
    static func == (lhs: FileContent, rhs: FileContent) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
//
//extension FileContent: Equatable {
//    static func == (lhs: FileContent, rhs: FileContent) -> Bool {
//        switch (lhs, rhs) {
//        case (let .photo(lhsPhoto), let .photo(rhsPhoto)):
//            return lhsPhoto == rhsPhoto
//        case (let .video(lhsVideo), let .video(rhsVideo)) :
//            return lhsVideo == rhsVideo
//        default:
//            return false
//        }
//    }
//}


/// Post videp
struct VideoPostViewModel: Equatable, Hashable {
    
    let videoURL: String
    var id: UUID { UUID() }

    static func == (lhs: VideoPostViewModel, rhs: VideoPostViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// James add posts here 
struct PhotoPostViewModel: Hashable, Equatable {
    
    let photoURL: String
    let image: UIImage? // for now
    var id: UUID { UUID() }

    static func == (lhs: PhotoPostViewModel, rhs: PhotoPostViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


/// MARK- Post feed full
struct FullPostViewModel {
    
    let contents: [PostViewModel]
    let comments: [CommentViewModel]
    let userOwner: UserViewModel
    let metaDataLocation: String
    let likedBy: [NotificationListItemViewModel]
    var id: UUID { UUID() }
    
    //    private enum CodingKeys : String, CodingKey { case contents, comments, userOwner, metaDataLocation, likedBy }
    
    var headerPostViewModel: HeaderPostViewModel {
        HeaderPostViewModel(user: userOwner, location: metaDataLocation)
    }
    
    /// used in tableview content detail
    static var stubFullPosts: [FullPostViewModel]  {
        PostViewModel.userFeedPosts.map {
            FullPostViewModel(contents: (0...3).mapRepeat($0), comments: [], userOwner: UserViewModel(id: "", userName: "Sasha", profilePicture: UIImage(named: "sashi")), metaDataLocation: "Somewhere around the world", likedBy: [])
        }
    }
}

extension FullPostViewModel: Equatable, Hashable {
    
    static func == (lhs: FullPostViewModel, rhs: FullPostViewModel) -> Bool {
        return
            lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// MARK:- Post feed small used in grids/
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

/// MARK: - Comments
struct CommentViewModel: Equatable {
    
    let userName: String
    let comment: String
}

/////////////////        ///////////////////         /////////////////

/// MARK:- Stories
struct StoryVideoCoverViewModel {
    
    let videoURL: String
    let videoCover: UIImage?
    let userOwner: UserStoryCoverViewModel
    var id: UUID { UUID() }
    
    static var storyVideoCovers: [StoryVideoCoverViewModel] {
        var covers: [StoryVideoCoverViewModel] = []
        for (i, userStoryProfileCoverViewModel) in UserStoryCoverViewModel.userProfileStoryCovers.enumerated() {
            let largeCoverImage = UIImage(named: "storySnippetPhoto\(i)")
            let viewModel = StoryVideoCoverViewModel(videoURL: "some", videoCover: largeCoverImage, userOwner: userStoryProfileCoverViewModel)
            covers.append(viewModel)
        }
        return covers
    }
}

extension StoryVideoCoverViewModel: Equatable, Hashable {
    static func == (lhs: StoryVideoCoverViewModel, rhs: StoryVideoCoverViewModel) -> Bool {
        return
            lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ClosedRange where Element == Int {
    
    func mapRepeat<T>(_ instance: T) -> [T] {
        var items: [T] = []
        for _ in self {
            items.append(instance)
        }
        return items
    }
}
