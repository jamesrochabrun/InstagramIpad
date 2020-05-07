//
//  HilightViewModel.swift
//  SplitViewControllerTutorial
//
//  Created by james rochabrun on 4/7/20.
//  Copyright © 2020 james rochabrun. All rights reserved.
//

import UIKit

// MARK:- Protocol
/**
- Remark:- protocol that allows UI reusability.
*/
protocol CircularCoverDisplayWithText {
    var cover: UIImage? { get }
    var title: String { get }
    var borderKind: BorderKind { get }
}

/**
- Remark:- viewModel that display user hilights cover, used in hilights carrousel cells.
*/
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
