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
        
        if(InternetMonitor.shared.internetStatus){
            task.resume()
        }else{
            let connAlert = UIAlertController(title: "Sin conexión", message: "Favor de validar la conexión a internet para continuar", preferredStyle: UIAlertController.Style.alert)
            
            self.show(connAlert, sender: self)
        }
        
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

}
