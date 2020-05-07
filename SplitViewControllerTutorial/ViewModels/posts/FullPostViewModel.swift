//
//  FullPostViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/3/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel for a post that contains all data, likes, comments etc.
*/
struct FullPostViewModel {
    
    let contents: [PostViewModel]
    let comments: [CommentViewModel]
    let userOwner: UserViewModel
    let metaDataLocation: String
    let likedBy: [NotificationListItemViewModel]
    var id: UUID { UUID() }

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

/// Helper.
extension ClosedRange where Element == Int {
    
    func mapRepeat<T>(_ instance: T) -> [T] {
        var items: [T] = []
        for _ in self {
            items.append(instance)
        }
        return items
    }
}
