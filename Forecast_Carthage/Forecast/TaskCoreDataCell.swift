//
//  TaskCoreDataCell.swift
//  Forecast
//
//  Created by Berezkin on 09.07.2020.
//  Copyright © 2020 Berezkin. All rights reserved.
//

import UIKit

class TaskCoreDataCell: UITableViewCell {
    
    @IBOutlet var taskText: UILabel!
    @IBOutlet var numberTaskLabel: UILabel!
    @IBAction func deleteRow(_ sender: Any) {
        self.delegate?.deleteButton(cell: self)
    }
    var delegate: TaskCoreDataCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

protocol TaskCoreDataCellDelegate{
    func deleteButton(cell: TaskCoreDataCell)
}
