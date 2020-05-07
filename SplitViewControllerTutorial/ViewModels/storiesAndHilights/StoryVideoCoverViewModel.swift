//
//  StoryVideoCoverViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by James Rochabrun on 5/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

/**
- Remark:- viewModel for a story cover displayed in a cell.
*/

struct StoryVideoCoverViewModel {
    
    let videoURL: String
    let videoCover: UIImage? // in a real app should be a URL
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
