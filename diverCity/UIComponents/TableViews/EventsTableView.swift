//
//  EventsTableView.swift
//  diverCity
//
//  Created by Lauren Shultz on 3/8/19.
//  Copyright © 2019 Lauren Shultz. All rights reserved.
//

import Foundation
import UIKit

class EventsTableView: UITableView {
    var eventsList: [CommunityEvent]
    var onEventSelected: (_ event: CommunityEvent) -> () = {_ in }
    
    init(frame: CGRect, eventsList: [CommunityEvent], eventSelectedCallback: @escaping (_ event: CommunityEvent) -> ()) {
        let style: UITableViewStyle = UITableViewStyle.plain
        onEventSelected = eventSelectedCallback
        self.eventsList = eventsList
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(EventTableCell.self, forCellReuseIdentifier: "eventCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadEvents(events: [CommunityEvent]) {
        self.eventsList = events
        self.reloadData()
    }
}

extension EventsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableCell
        cell.eventItemView.loadEvent(event: eventsList[indexPath.row])
        //cell.textLabel?.text = eventsList[indexPath.row].name
        //cell.detailTextLabel?.text = eventsList[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onEventSelected(eventsList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
