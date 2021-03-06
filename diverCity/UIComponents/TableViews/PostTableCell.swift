//
//  PostTableCell.swift
//  diverCity
//
//  Created by Lauren Shultz on 3/8/19.
//  Copyright © 2019 Lauren Shultz. All rights reserved.
//

import Foundation
import UIKit

class PostTableCell: UITableViewCell {
    var postView: PostView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        postView = PostView(x: self.contentView.frame.minX, y: self.contentView.frame.minY, width: self.contentView.frame.width)
        
        self.contentView.addSubview(postView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
