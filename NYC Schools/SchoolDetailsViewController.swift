//
//  SchoolDetailsViewController.swift
//  NYC Schools
//
//  Created by Adam Joshua Mohammad on 7/15/22.
//
// This file recieves the dbn of the school that its cell refers to and performs an API request on the second JSON file, matches the dbn, and displays the corresponding SAT scores.

import UIKit
import Alamofire
import SwiftyJSON

class SchoolDetailsViewController: UIViewController {
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var readingScore: UILabel!
    @IBOutlet weak var writingScore: UILabel!
    @IBOutlet weak var mathScore: UILabel!
    
    //the school var is used to display the school name in the label
    //the dbn var is used during the API request to lookup the correct school
    var school: String = ""
    var dbn: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Displaying the school name calling the api func
        schoolName.text = school
        apiCall()
    }
    
    func apiCall() {
        
        let url = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        AF.request(url).responseJSON{(AFResponse) in

            guard let JSONData = AFResponse.data else {
                return
            }
            do{
                if let schoolData = try? JSON(data: JSONData)
                {
                    for schools in schoolData {
                        let testdbn = schools.1
                        //find the school with a matching dbn as the one returned from SchoolsViewController
                        if testdbn["dbn"].stringValue == self.dbn {
                            //when a matching dbn is found, display the school's scores
                            self.writingScore.text = testdbn["sat_writing_avg_score"].stringValue
                            self.readingScore.text = testdbn["sat_critical_reading_avg_score"].stringValue
                            self.mathScore.text = testdbn["sat_math_avg_score"].stringValue
                        }
                        //if the school is not found, display data not found
                        else {
                            self.writingScore.text = "Data not found"
                            self.readingScore.text = "Data not found"
                            self.mathScore.text = "Data not found"
                        }
                    }
                }

            }
        }
    }
}
