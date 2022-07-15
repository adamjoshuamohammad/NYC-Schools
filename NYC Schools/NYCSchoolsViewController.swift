//
//  NYCSchoolsViewController.swift
//  NYC Schools
//
//  Created by Adam Joshua Mohammad on 7/15/22.
//
//I decided to make the API Call on a screen before the Table View because the app was crashing when the Table cells were trying to populate before the API call was completed.

import UIKit
import Alamofire
import SwiftyJSON

class NYCSchoolsViewController: UIViewController {
    
    //arrays to hold the list of 1. school names (for the table view cells) and 2. database numbers (to identify the right schools in the sat score JSON)
    var schoolNames: [String] = []
    var dbnNums: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
}

//this function makes the API Request and appends all school names and database numbers to their respective arrays
func apiCall() {
    
    let url = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    AF.request(url).responseJSON{(AFResponse) in

    guard let JSONData = AFResponse.data else {
        return
    }

    do{
        if let schoolData = try? JSON(data: JSONData)
        {
            //diving in to retrieve the school name and dbn
            for sections in schoolData {
                for schools in sections.1 {
                    if (schools.0 == "school_name"){
                        self.schoolNames.append(schools.1.stringValue)
                        //print(self.schoolNames)
                    }
                    if (schools.0 == "dbn"){
                        self.dbnNums.append(schools.1.stringValue)
                        //print(self.dbnNums)
                    }
                }
            }
        }

    }
}
}
    
    //sending the schoolNames and dbnNums arrays to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let NYCSchoolsViewController = segue.destination as? SchoolsViewController {
          NYCSchoolsViewController.schoolNames = schoolNames
            NYCSchoolsViewController.dbnNums = dbnNums
        }
      }
    
    //clicking the View button takes you to the next screen
    //I went with an intro screen and button because the table view kept crashing since it was waiting on the API call
    @IBAction func startAPP(_ sender: Any) {
        performSegue(withIdentifier: "toSchoolSegue", sender: self)
    }
}
