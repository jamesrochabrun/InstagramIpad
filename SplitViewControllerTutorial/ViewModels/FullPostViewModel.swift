//
//  FullPostViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/3/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// Dummy data

struct PostMockData {
    
    static var userProfilePhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "post\(i)"))
        }
        return photos.compactMap { $0 }
    }
    
    static var homeFeedPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "home\(i)"))
        }
        return photos.compactMap { $0 }
    }
    
    static var searchFeedPlaceholderPhotos: [UIImage] {
        var photos: [UIImage?] = []
        for i in 0...36 {
            photos.append(UIImage(named: "search\(i)"))
        }
        return photos.compactMap { $0 }
    }
}

/// MARK:- Post kinds
enum FileContent {
    case video(VideoPostViewModel)
    case photo(PhotoPostViewModel)
}

extension FileContent: Equatable {
    static func == (lhs: FileContent, rhs: FileContent) -> Bool {
        switch (lhs, rhs) {
        case (let .photo(lhsPhoto), let .photo(rhsPhoto)):
            return lhsPhoto == rhsPhoto
        case (let .video(lhsVideo), let .video(rhsVideo)) :
            return lhsVideo == rhsVideo
        default:
            return false
        }
    }
}

extension FileContent: ContentCollection {}

/// Post videp
struct VideoPostViewModel: Equatable {
    
    let videoURL: String
    static var videos: [VideoPostViewModel] {
        (0...50).mapRepeat(VideoPostViewModel(videoURL: ""))
    }
}


/// James add posts here 
struct PhotoPostViewModel {
    let photoURL: String
    let image: UIImage? // for now
    static var photos: [PhotoPostViewModel] {
        (0...50).mapRepeat(PhotoPostViewModel(photoURL: "", image: UIImage(named: "zizou")))
    }
}

extension PhotoPostViewModel: Equatable {
    
}

/// MARK- Post feed full
struct FullPostViewModel {
    
    let contents: [FileContent]
    let comments: [CommentViewModel]
    let userOwner: UserViewModel
    let metaDataLocation: String
    let likedBy: [NotificationListItemViewModel]
    var id: UUID {
        UUID()
        
    }
    
    private enum CodingKeys : String, CodingKey { case contents, comments, userOwner, metaDataLocation, likedBy }

    
    var headerPostViewModel: HeaderPostViewModel {
        HeaderPostViewModel(user: userOwner, location: metaDataLocation)
    }
    
    static var empty: FullPostViewModel {
        
        FullPostViewModel(contents: PhotoPostViewModel.photos.map { FileContent.photo($0) },
                      comments: [CommentViewModel(userName: "James", comment: "wow so cool")],
                      userOwner: UserViewModel(id: "", userName: "Sasha", profilePicture: UIImage(named: "sashi")),
                      metaDataLocation: "London",
                      likedBy: [])
    }
    
    static var posts: [FullPostViewModel] {
        (0...50).mapRepeat(FullPostViewModel.empty)
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


/// MARK:- Post feed small
struct PostViewModel {
    
    let id: String
    let content: FileContent
    
    static var userFeedPosts: [PostViewModel] {
        PostMockData.userProfilePhotos.map { PostViewModel(id: "id", content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
    }
    
    static var homeFeedPosts: [PostViewModel] {
        PostMockData.homeFeedPhotos.map { PostViewModel(id: "id", content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
    }
    
    static var searchFeedPlaceholderPosts: [PostViewModel] {
        PostMockData.searchFeedPlaceholderPhotos.map { PostViewModel(id: "id", content: .photo(PhotoPostViewModel(photoURL: "", image: $0))) }
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

extension ClosedRange where Element == Int {
    
    func mapRepeat<T>(_ instance: T) -> [T] {
        var items: [T] = []
        for _ in self {
            items.append(instance)
        }
        return items
    }
}
