//
//  CommunityTableView.swift
//  diverCity
//
//  Created by Lauren Shultz on 3/8/19.
//  Copyright © 2019 Lauren Shultz. All rights reserved.
//

import Foundation
import UIKit

class CommunityTableView: UITableView {
    var communities: [Community] = []
    var onCommunityClicked: (_ Community: Community) -> () = {_ in }
    
    init(frame: CGRect, communities: [Community], communitySelectedCallback: @escaping (_ community: Community) -> ()) {
        let style: UITableViewStyle = UITableViewStyle.plain
        onCommunityClicked = communitySelectedCallback
        self.communities = communities
        super.init(frame: frame, style: style)
        self.register(CommunityTableCell.self, forCellReuseIdentifier: "communityCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommunityTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = communities[indexPath.row].name
        cell?.detailTextLabel?.text = communities[indexPath.row].description
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserSession.selectedCommunity = communities[indexPath.row]
        onCommunityClicked(communities[indexPath.row])
    }
}