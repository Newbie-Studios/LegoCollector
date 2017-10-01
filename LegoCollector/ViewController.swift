//
//  ViewController.swift
//  LegoCollector
//
//  Created by Jamie Roberts on 26/09/2017.
//  Copyright © 2017 Newbie-Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { //added our data source and delegate
    
    @IBOutlet weak var tableView: UITableView!
    
    var legos : [Lego] = [] //create variable equal to our core data
    
    //comment for some source control (away from source tree?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self //marked the data source as self
        tableView.delegate = self //and the delegate as self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legos.count
    } //number of rows in section equal to count of Core Data
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() //created cel constant equal to UITableViewCell
        let legoTable = legos[indexPath.row] //created constant equal to indexpath.row of legos (and subsequently core data)
        cell.textLabel?.text = legoTable.name //label of the cell constant is the name of the legoTable constant which is equal to the current row of core data
        cell.imageView?.image = UIImage(data: legoTable.image as! Data) //image is pulled back into the view too. Note the UIImage(data: etc) bit is relevant as it enables us to convert the NS data back or some shit
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let legoTable = legos[indexPath.row] //created constant equal to indexpath.row of legos (and subsequently core data)
        performSegue(withIdentifier: "gameSegue", sender: legoTable) //performs a seqgue when tapped
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //prepare for segue
        let nextVC = segue.destination as! AddViewController //nextVC constant is equal to the destination of the seque to AddViewController
        nextVC.lego = sender as? Lego
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //brough in core data context
        do{
            legos = try context.fetch(Lego.fetchRequest()) //this is how we get core data across into the view did appear - fairly standard
            print(legos)
            tableView.reloadData()
        } catch{
        }
    }
    
    
    
    
    
}
