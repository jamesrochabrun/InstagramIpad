//
//  HilightViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit


// Hilights
struct HilightViewModel {
    
    let hilightTitle: String
    let hilightCover: UIImage?
    let hilightBorder: BorderKind = .none
    
    static var mockHilights: [HilightViewModel] {
        var hilightSnippets: [HilightViewModel?] = []
        for i in 0...13 {
            guard let image = UIImage(named: "hilightSnippet\(i)") else { continue }
            hilightSnippets.append(HilightViewModel(hilightTitle: "\(i)", hilightCover: image))
        }
        return hilightSnippets.compactMap { $0 }
    }
}

extension HilightViewModel: CircularCoverDisplayWithText {
    var title: String { hilightTitle }
    var cover: UIImage? { hilightCover }
    var borderKind: BorderKind { hilightBorder }
}

// user profile and etxt
struct UserStoryCoverViewModel {
    let userName: String
    let userCover: UIImage?
    let hilightBorder: BorderKind = .gradient
    
    static var userProfileStoryCovers: [UserStoryCoverViewModel] {
        var covers: [UserStoryCoverViewModel] = []
        for enumerated in UsersMockData.userNames.enumerated() {
            let userCover = UserStoryCoverViewModel(userName: enumerated.element, userCover: UIImage(named: "prof\(enumerated.offset)"))
            covers.append(userCover)
        }
        return covers
    }
}

extension UserStoryCoverViewModel: CircularCoverDisplayWithText {
    var title: String { userName }
    var cover: UIImage? { userCover }
    var borderKind: BorderKind { hilightBorder }
}

protocol CircularCoverDisplayWithText {
    var cover: UIImage? { get }
    var title: String { get }
    var borderKind: BorderKind { get }
}

