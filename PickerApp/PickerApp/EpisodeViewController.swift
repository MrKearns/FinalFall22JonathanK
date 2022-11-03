//
//  EpisodeViewController.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 10/17/22.
//

import UIKit
import ColorKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
//    ------------------ VARIABLES & CONSTANTS ----------------
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var episodedTable: UITableView!
    @IBOutlet weak var sortEpisodesButton: UIButton!
    
    var episodesArray: [Episode] = []
    var allEpisodesArray: [Episode] = []
    var playedEpisodesArray: [Episode] = []
    var unplayedEpisodesArray: [Episode] = []
    
    var podcastTitle = String()
    var podcastDiscription = String()
    
    var coverImageToGetAverageColor: UIImageView!
    
    
    
  
    
    
    
//    ------------------- VIEW DID LOAD --------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = podcastTitle
        descriptionLabel.text = podcastDiscription
        
        getImageAverageColor()
        
        
        episodesArray = unplayedEpisodesArray
        sortEpisodeButtonPressed()
        

        // Do any additional setup after loading the view.
    }
    
    
//    ------------------- TABLEVIEW FUNCTIONS ----------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "episodesCell") as! TableViewCell
        
        cell.backgroundColor = UIColor.lightGray
        cell.episodeTitle?.text = episodesArray[indexPath.row].name
        cell.episodeNumber?.text = "\(episodesArray[indexPath.row].episodeNumber)"
        cell.episodeDate?.text = "\(String(describing: episodesArray[indexPath.row].datePublished))"
        
        return cell
    }
    
//    -----------------
   
    func sortEpisodeButtonPressed() {
        let this = { [self](action: UIAction) in
            if action.title == "Unplayed"{
                self.episodesArray = self.unplayedEpisodesArray
                episodedTable.reloadData()
            }
            if action.title == "All"{
                self.episodesArray = self.allEpisodesArray
                episodedTable.reloadData()
            }
            if action.title == "Played"{
                self.episodesArray = self.playedEpisodesArray
                episodedTable.reloadData()
            }
            print(action.title)}
        
        
        
    
        
        sortEpisodesButton.menu = UIMenu(children: [
            UIAction(title: "Unplayed", state: .on, handler: this),
            UIAction(title: "Played", state: .on, handler: this),
            UIAction(title: "All", state: .on, handler: this)
        ])
    }
    
    
    
    func getImageAverageColor(){
        do{
            let averageColor = try coverImageToGetAverageColor.image?.dominantColors()
            view.backgroundColor = averageColor![0]
            topLabel.textColor = averageColor![1]
            descriptionLabel.textColor = averageColor![1]
            sortEpisodesButton.setTitleColor(averageColor![1], for: .normal)
          
        }
        catch{
            print("color error")
        }
    }
    
}
