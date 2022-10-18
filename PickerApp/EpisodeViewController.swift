//
//  EpisodeViewController.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 10/17/22.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
//    ------------- VARIABLES & CONSTANTS -----------
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var episodedTable: UITableView!
    
    let episodesArray = ["ep1", "ep2"]
    
    var podcastTitle = String()
    
    
    
//    ------------- VIEW DID LOAD -------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = podcastTitle

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "epCell")
        cell?.backgroundColor = UIColor.gray
        cell?.textLabel?.text = episodesArray[indexPath.row]
        return cell!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
