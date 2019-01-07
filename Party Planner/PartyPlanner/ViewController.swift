//
//  ViewController.swift
//  PartyPlanner
//
//  Created by Jolene Lozano on 10/16/18.
//  Copyright © 2018 Jolene Lozano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    var partyItems = ["Potato Chips",
                      "Tortilla Chips",
                      "Salsa",
                      "Chili",
                      "Punch",
                      "Sudsy Beverages",
                      "Brownies",
                      "Cupcakes",
                      "Fruit salad",
                      "Ribs",
                      "Corn bread",
                      "Macaroni Salad",
                      "Sandwich Rolls",
                      "Roast Beef",
                      "Ham",
                      "Cheese",
                      "Mayo",
                      "Mustard",
                      "Hummus",
                      "Baby carrots",
                      "Celery",
                      "Veggie Dip",
                      "Napkins",
                      "Plates & Bowls",
                      "Forks and Knives",
                      "Cups"]
    
    var peopleResponsible: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for _ in partyItems {
            peopleResponsible.append("")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            let destination = segue.destination as! ItemDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.partyItem = partyItems[selectedIndexPath.row]
            destination.personResponsible = peopleResponsible[selectedIndexPath.row]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromItemDetailViewController(segue: UIStoryboardSegue) {
        let source = segue.source as! ItemDetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            partyItems[selectedIndexPath.row] = source.partyItem
            peopleResponsible[selectedIndexPath.row] = source.personResponsible
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: partyItems.count, section: 0)
            partyItems.append(source.partyItem)
            peopleResponsible.append(source.personResponsible)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = partyItems[indexPath.row]
        cell.detailTextLabel?.text = peopleResponsible[indexPath.row]
        return cell
    }

}
