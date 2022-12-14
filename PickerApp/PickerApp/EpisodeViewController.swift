//
//  EpisodeViewController.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 10/17/22.
//

import UIKit
import ColorKit
import AVFoundation

// ----- PUBLIC VARS -----

var primaryColor: UIColor?
var secondaryColor: UIColor?
var tertiaryColor: UIColor?


    // ---------------------- VIEW CONTROLLER ----------------------

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //    -------------------- VARIABLES & CONSTANTS ------------------
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var episodesTable: UITableView!
    @IBOutlet weak var sortEpisodesButton: UIButton!
    
    var episodesArray: [Episode] = []
    var allEpisodesArray: [Episode] = []
    var playedEpisodesArray: [Episode] = []
    var unplayedEpisodesArray: [Episode] = []
    
    var podcastTitle = String()
    var podcastDiscription = String()
    
    var coverImageToGetAverageColor: UIImageView!
    var audioFileToSend: String = ""
    
    
    
    
    
    
    
    //    -------------------- VIEW DID LOAD -----------------------
    
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
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "episodesCell") as! TableViewCell
        
        cell.backgroundColor = UIColor.lightGray
        cell.episodeTitle?.text = episodesArray[indexPath.row].name
        cell.episodeNumber?.text = "\(episodesArray[indexPath.row].episodeNumber)"
        cell.episodeDate?.text = "\(String(describing: episodesArray[indexPath.row].datePublished))"
        
        return cell
    }
    
    
//    ----- DID SELECT ROW -----
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        audioFileToSend = allEpisodesArray[indexPath.row].audioFile
        performSegue(withIdentifier: "segueToPlayer", sender: self)
    }
    
    
//    ----- TRAILING SWIPE ACTION -----
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAsPlayed = UIContextualAction(style: .normal, title: "Played") {
            (contextualAction, view, boolValue) in
            self.episodesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [markAsPlayed])
        return swipeActions
        
    }
    
    
//    -------------------- PREPARE FOR SEGUE -------------------
    
    override func prepare(for segueToPlayer: UIStoryboardSegue, sender: Any?) {
        let playerController = segueToPlayer.destination as! PlayerViewController
        
        playerController.podcastAudioFile = audioFileToSend
    }

    
    
    
//    ----------------- SORT BUTTON / POP UP BUTTON FUNCTION --------------------
   
    func sortEpisodeButtonPressed() {
        let this = { [self](action: UIAction) in
            if action.title == "Unplayed"{
                self.episodesArray = self.unplayedEpisodesArray
                episodesTable.reloadData()
            }
            if action.title == "All"{
                self.episodesArray = self.allEpisodesArray
                episodesTable.reloadData()
            }
            if action.title == "Played"{
                self.episodesArray = self.playedEpisodesArray
                episodesTable.reloadData()
            }
            print(action.title)}
    
        sortEpisodesButton.menu = UIMenu(children: [
            UIAction(title: "Unplayed", state: .on, handler: this),
            UIAction(title: "Played", state: .on, handler: this),
            UIAction(title: "All", state: .on, handler: this)
        ])
    }
    
    
//    -------------------- GET COLORS FROM IMAGE FUNCTION ----------------
    
    func getImageAverageColor(){
        do{
            let averageColor = try coverImageToGetAverageColor.image?.dominantColors()
            view.backgroundColor = averageColor![0]
            primaryColor = averageColor![0]
            topLabel.textColor = averageColor![1]
            secondaryColor = averageColor![1]
            tertiaryColor = averageColor![2]
            descriptionLabel.textColor = averageColor![1]
            sortEpisodesButton.setTitleColor(averageColor![1], for: .normal)
        }
        catch{
            print("color error")
        }
    }
    
}
