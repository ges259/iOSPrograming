//
//  DetailViewController.swift
//  iOS_APP_1
//
//  Created by 계은성 on 2023/06/07.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var artistTableView: UITableView!
    
    
    
    var musicArray: [Music] = []
    
    
    let networkManager = NetworkManager.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupTable()
    }
    
    
    
    private func setupTable() {
        artistTableView.dataSource = self
        artistTableView.delegate = self
    }
}



// MARK: - tableView_Delegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}


// MARK: - tableView_DataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artistTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.imageUrl = musicArray[indexPath.row].imageUrl
        cell.cellArtistName.text = musicArray[indexPath.row].artistName
        cell.cellMusicName.text = musicArray[indexPath.row].songName
        
        return cell
    }
}
