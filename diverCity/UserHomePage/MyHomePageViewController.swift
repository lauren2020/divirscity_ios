//
//  MyHomePageViewController.swift
//  diverCity
//
//  Created by Lauren Shultz on 10/12/18.
//  Copyright © 2018 Lauren Shultz. All rights reserved.
//

import UIKit

class MyHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var myCommunitiesTableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let comm1 = Community(name: "Omaha", privacyType: PrivacyType(visibility: 0), creator: UserSession.user!)
//        comm1.description = "Nebraska's largest city"
//        let comm2 = Community(name: "DoSpace", privacyType: PrivacyType(visibility: 0), creator: UserSession.user!)
//        comm2.description = "Omaha's technology library"
//        let comm3 = Community(name: "Nathan Hale", privacyType: PrivacyType(visibility: 0), creator: UserSession.user!)
//        comm3.description = "The home of the Patriots"
//        let comm4 = Community(name: "Lewis & Clark", privacyType: PrivacyType(visibility: 0), creator: UserSession.user!)
//        comm4.description = "Middle Scholl at 72nd & Cass"
//        UserSession.user?.communities = [comm1, comm2, comm3, comm4]

        // Do any additional setup after loading the view.
        UserSession.user?.communities = []
        for communityId in (UserSession.user?.communityIds)! {
            Community.communityInfo(withId: String(communityId), completion: setCommunities)
        }
        headerName.text = "| " + (UserSession.user?.firstName)! + " " + (UserSession.user?.lastName)!
        myCommunitiesTableList.delegate = self
        myCommunitiesTableList.dataSource = self
    }
    
    func setCommunities(newCommunity: Community?) {
        if (newCommunity != nil) {
            UserSession.user?.communities.append(newCommunity!)
        } else {
            print("Failed to retrieve community!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSession.user!.communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myCommunitiesTableList.dequeueReusableCell(withIdentifier: "cell")
        //print("Cell1: ", cell)
        //print("Comms: ", user.communities)
        cell?.textLabel?.text = UserSession.user!.communities[indexPath.row].name
        cell?.detailTextLabel?.text = UserSession.user!.communities[indexPath.row].description
        //print("Cell2: ", cell)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserSession.selectedCommunity = UserSession.user!.communities[indexPath.row]
        self.performSegue(withIdentifier: "myHomePageToCommunityHomePage", sender: (Any).self)
    }
    
    @IBAction func reloadCommunities(_ sender: Any) {
        print(UserSession.user?.communities)
        myCommunitiesTableList.reloadData()
    }
    
    @IBAction func goToFindCommunities(_ sender: Any) {
        performSegue(withIdentifier: "myHomePageToFindCommunities", sender: (Any).self)
    }
    
    @IBAction func logoutOfAccount(_ sender: Any) {
        performSegue(withIdentifier: "myHomePageToWelcome", sender: (Any).self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}