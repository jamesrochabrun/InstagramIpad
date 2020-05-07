//
//  FileContent.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit


/**
- Remark:- viewModel that handles a file content kind, video or photo, video not supported.
*/
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

/**
- Remark:- FileContent video
*/
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

/**
- Remark:- FileContent Photo
*/struct PhotoPostViewModel: Hashable, Equatable {
    
    let photoURL: String
    let image: UIImage? // for now, should be an URL in a real app
    var id: UUID { UUID() }

    static func == (lhs: PhotoPostViewModel, rhs: PhotoPostViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
