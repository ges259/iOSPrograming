//
//  TableViewCell.swift
//  iOS_APP_1
//
//  Created by 계은성 on 2023/06/07.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellMusicName: UILabel!
    
    @IBOutlet weak var cellArtistName: UILabel!
    
    
    
    
    
    // TableViewCell
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let urlStirng = imageUrl, let url = URL(string: urlStirng)  else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            guard urlStirng == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.cellImageView.image = UIImage(data: data)
            }
        }
    }
    

    override func prepareForReuse() {
        self.cellImageView.image = nil
    }
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
