//
//  HomeTableViewCell.swift
//  WeatherApp
//
//  Created by Alisher Abdukarimov on 6/22/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    var weatherData: [Weather] = [] {
        didSet {
            collectionViewOutlet.reloadData()
        }
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

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
            cell.collectionImageView.image = UIImage(named: weatherData[indexPath.row].icon)
            cell.collectionImageTitleLbl.text = "\(Int(weatherData[indexPath.row].temperature))"
            cell.dateLabel.text = weatherData[indexPath.row].summary
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
    }
    
}

class CustomCollectionCell: UICollectionViewCell  {
    
    @IBOutlet var collectionImageView: UIImageView!
    @IBOutlet var collectionImageTitleLbl: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLayer()
    }
    
    func setUpLayer() {
        
        collectionImageView.layer.cornerRadius = 5
        collectionImageView.contentMode = .scaleAspectFit
        collectionImageView.clipsToBounds = true
        collectionImageView.layer.shadowOpacity = 0.7
        collectionImageView.layer.shadowRadius = 10.0
    }
}

