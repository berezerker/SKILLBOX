//
//  WeatherCell.swift
//  Forecast
//
//  Created by Berezkin on 01.07.2020.
//  Copyright © 2020 Berezkin. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet weak var  dayLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
