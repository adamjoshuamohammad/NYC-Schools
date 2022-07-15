//
//  ViewController.swift
//  NYC Schools
//
//  Created by Adam Joshua Mohammad on 7/14/22.
//
// The Table View file that displays the list of schools and allows user to click into a school to find out its SAT scores.

import UIKit
import Alamofire
import SwiftyJSON

class SchoolsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //the two arrays for school names and database numbers passed in from the NYCSchoolsViewController
    var schoolNames: [String] = []
    var dbnNums: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //number of rows is based on number of items in schoolNames array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolNames.count
    }
    
    //cells of the tableView are populated by names of schools from schoolNames array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell", for: indexPath)
        
        cell.textLabel?.text = schoolNames[indexPath.row]
        
        return cell
    }
    
    //used indexPath.row as a way to correspond the school name with its corresponding dbn to send to the SchoolDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SchoolsViewController = segue.destination as? SchoolDetailsViewController {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            //storing the schoolName and dbn of the specific cell to give to the next View Controller
            let school = schoolNames[indexPath.row]
            let dbn = dbnNums[indexPath.row]
            
            let schoolDetailsViewController = segue.destination as! SchoolDetailsViewController
            
            //sending the SchoolDetailsViewController the school name and dbn that the cell refers to
            schoolDetailsViewController.school = school
            schoolDetailsViewController.dbn = dbn
        }
      }

}
