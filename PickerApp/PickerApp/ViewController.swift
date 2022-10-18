//
//  ViewController.swift
//  PickerApp
//
//  Created by Jonathan Kearns on 9/19/22.
//

import UIKit

// ------------- PODCAST & EPISODE STRUCTS ------------


struct Podcast{
    var name: String
    var description: String
    var genre: String
    var coverArt: String
    var network: String?
    var subscribed: Bool
    var dateAdded: String
    var episodes: [Episode]
    
}

extension Podcast{
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.mm.dd"
        return formatter
    }()


var dateFromString : Date  {
    let DateString = dateAdded.components(separatedBy: ".").reversed().joined(separator: ".")
    return Podcast.dateFormatter.date(from: DateString)!
    }
}


struct Episode {
    var name: String
    var audioFile: String
    var episodeNumber: Int
    var seasonNumber: Int?
    var datePublished: Date?
    var description: String
    var episodeArt: String
    var length: TimeInterval
    var currentPlay: TimeInterval
    var timeRemaining: TimeInterval{
        get {
            return length - currentPlay
        }
    }
    var played: Bool?
    var favorited: Bool
}


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
//    ------------- VARIABLES & CONSTANTS ----------
    
    @IBOutlet weak var myPicker: UIPickerView!
    var podcastArray: [String] = [String]()
    var podcasts: [Podcast] = []
    
    var backgroundColors = [UIColor.red, UIColor.gray, UIColor.yellow, UIColor.green, UIColor.white, UIColor.black]
    
    @IBOutlet weak var sortButton: UIButton!
    var pressSort = true
    
    @IBOutlet weak var roundEpisodedButton: UIButton!
    
    var pickerLabelToSend = "Hi"
    var pickerLabel = ""
    
    
    //    ------------- VIEW DID LOAD --------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPicker.delegate = self
        myPicker.dataSource = self
//        podcastArray = ["Comedy Bang Bang", "This American Life", "Serial", "Get Played", "Superego", "James Bonding", "With Gourley and Rust", "The Neighborhood Listen", "Man Dog Pod"]
      
        roundEpisodedButton.layer.cornerRadius = roundEpisodedButton.frame.width / 2
        roundEpisodedButton.layer.masksToBounds = true
        
        
        podcasts = [Podcast(name: "Comedy Bang Bang", description: "A comedy Podcast", genre: "Comedy", coverArt: "", subscribed: true, dateAdded: "05.01.2009", episodes: [Episode(name: "Ep 1", audioFile: "" , episodeNumber: 1, description: "The First episode", episodeArt: "", length: 3500, currentPlay: 300, favorited: false),
            Episode(name: "Ep 2", audioFile: "" , episodeNumber: 2, description: "The Second episode", episodeArt: "", length: 3600, currentPlay: 3600, favorited: false),
            Episode(name: "Ep 3", audioFile: "" , episodeNumber: 3, description: "The Third episode", episodeArt: "", length: 4000, currentPlay: 4000, favorited: false)]),
                        
            Podcast(name: "This American Life", description: "Storytelling", genre: "Personal Stories", coverArt: "", subscribed: true, dateAdded: "05.01.2009", episodes:
            [Episode(name: "Ep 1", audioFile: "" , episodeNumber: 1, description: "The First episode", episodeArt: "", length: 3500, currentPlay: 300, favorited: false),
            Episode(name: "Ep 2", audioFile: "" , episodeNumber: 2, description: "The Second episode", episodeArt: "", length: 3600, currentPlay: 3600, favorited: false),
            Episode(name: "Ep 3", audioFile: "" , episodeNumber: 3, description: "The Third episode", episodeArt: "", length: 4000, currentPlay: 4000, favorited: false)]),
                        
            Podcast(name: "Serial", description: "Storytelling", genre: "True Crime", coverArt: "", subscribed: true, dateAdded: "05.01.2009", episodes:
            [Episode(name: "Ep 1", audioFile: "" , episodeNumber: 1, description: "The First episode", episodeArt: "", length: 3500, currentPlay: 300, favorited: false),
            Episode(name: "Ep 2", audioFile: "" , episodeNumber: 2, description: "The Second episode", episodeArt: "", length: 3600, currentPlay: 3600, favorited: false),
            Episode(name: "Ep 3", audioFile: "" , episodeNumber: 3, description: "The Third episode", episodeArt: "", length: 4000, currentPlay: 4000, favorited: false)]),
        
        
        
        ]
        
        print(podcasts.count)
        
        
        
    }
    
    
//    ------------- SORT BUTTON --------------
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        pressSort.toggle()
        if pressSort == true {
            podcastArray.sort(by: <)
            myPicker.reloadAllComponents()
        } else {
            podcastArray.sort(by: >)
            myPicker.reloadAllComponents()
        }
    }
    
    
    //  -------------- PREPARE FOR SEGUE --------------
    
    override func prepare(for segueToEpisodes: UIStoryboardSegue, sender: Any?) {
       let eposidesController = segueToEpisodes.destination as! EpisodeViewController
        eposidesController.podcastTitle = pickerLabelToSend
        
        
    }
    
    
    
//    ------------- PICKERVIEW FUNCTIONS -------------
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return podcastArray.count
        return podcasts.count
        
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
//        return pickerData[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Futura Medium", size: 50)
            pickerLabel?.adjustsFontSizeToFitWidth = true;
            pickerLabel?.textAlignment = .left


        }
        pickerLabel?.text = podcasts[row].name
        pickerView.backgroundColor = backgroundColors.randomElement()
        pickerLabel?.numberOfLines = 0
//        pickerLabel?.text = podcastArray[row].uppercased()
        
        
        pickerLabel?.textColor = UIColor.blue

        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let pickerIndex = myPicker.selectedRow(inComponent: 0)
//        let alert = UIAlertController(title: "Your Choice", message: "\(pickerData[pickerIndex])", preferredStyle: .alert)
//
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
//            action -> Void in
//        })
//
//        alert.addAction(okAction)
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func pickerView(_ pickerView: UIPickerView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
//            (contextualAction, view, boolValue) in
//            self.podcastArray.remove(at: indexPath.row)
////            UserDefaults.standard.set(self.podArray, forKey: "myArray")
//        }
//
//            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
//            return swipeActions
//
//        }


    
//    ------------- BOTTOM BUTTON TAPPED ------------
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let pickerIndex = myPicker.selectedRow(inComponent: 0)
        pickerLabelToSend = "\(podcasts[pickerIndex].name)"
        performSegue(withIdentifier: "segueToEpisodes", sender: self)
//        let alert = UIAlertController(title: "Your Choice", message: "\(pickerData[pickerIndex])", preferredStyle: .alert)
//
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
//            action -> Void in
//        })
//
//        alert.addAction(okAction)
//
//        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

