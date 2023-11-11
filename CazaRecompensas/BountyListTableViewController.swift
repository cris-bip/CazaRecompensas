//
//  BountyListTableViewController.swift
//  CazaRecompensas
//
//  Created by OITD on 11/11/23.
//

import UIKit

class BountyListTableViewController: UITableViewController {
    
    var loadedFugitives : [Fugitive] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://janzelaznog.com/DDAM/iOS/BountyHunter/fugitives.json")!
        
        let session = URLSession.shared
        var httpResponse = HTTPURLResponse()
                    
        let task = session.dataTask(with: url) { (data, response, error) in
            do{
                self.loadedFugitives = try JSONDecoder().decode([Fugitive].self, from: data!)
                
                self.loadedFugitives.forEach { Fugitive in
                    print(Fugitive.fugitiveid)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedFugitives.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell

        let fugitive = loadedFugitives[indexPath.row]
        cell.textLabel?.text = fugitive.name
        cell.detailTextLabel?.text = String(format:"%d", fugitive.bounty)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
