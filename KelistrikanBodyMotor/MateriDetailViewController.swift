//
//  MateriDetailViewController.swift
//  KelistrikanBodyMotor
//
//  Created by Kelny Tan on 28/04/21.
//

import UIKit

class MateriDetailViewController: UIViewController {
    static let segue = "ShowToolDetailSegue"
    var materiModels: MateriModel!
    var judulMateri: Judul?
    
    @IBOutlet weak var materiImageView: UIImageView!
    @IBOutlet weak var materiTitleLabel: UILabel!
    @IBOutlet weak var materiDeskripsiLabel: UILabel!
    @IBOutlet weak var materiToolsTable: UITableView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var toolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        materiToolsTable.layer.cornerRadius = 10
        playButton.layer.cornerRadius = 10
        
        materiToolsTable.dataSource = self
        materiToolsTable.delegate = self
        
        // di bawah ini hanya test data
        materiModels = getMateriByNama(nama: judulMateri?.rawValue ?? "")
        // kalau judul tidak ada, crash! judul yang tidak dicode ke dalam juga crash
        
        // balik ke kode
        materiTitleLabel.text = "Tentang \(materiModels.materiJudul ?? "")"
        materiDeskripsiLabel.text = materiModels.materiDeskripsi
        materiImageView.image = UIImage(named: materiModels.materiImage!)
        navigationItem.title = materiModels.materiJudul
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ToolDetailViewController, let cell = sender as? Int{
            vc.toolName = materiModels.materiToolsNames[cell]
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        } else if let vc = segue.destination as? PlayViewController {
            vc.type = judulMateri
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    @IBAction func playInteractiveLesson(_ sender: Any) {
        // masukin source code buat bagian interaktifnya
    }
}

extension MateriDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.materiModels.materiToolsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "materiToolsCell", for: indexPath)
        let index = materiModels.materiToolsNames[indexPath.row]
        cell.textLabel?.text = index
        cell.textLabel?.textColor = UIColor.white
        cell.tintColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Self.segue, sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
