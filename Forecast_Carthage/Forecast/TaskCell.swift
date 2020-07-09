//
//  TaskCell.swift
//  Forecast
//
//  Created by Berezkin on 08.07.2020.
//  Copyright © 2020 Berezkin. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBAction func deleteRow(_ sender: Any) {
        self.delegate?.deleteButton(cell: self)
    }
    @IBOutlet weak var numberTaskLabel: UILabel!
    @IBOutlet weak var taskText: UILabel!
    var delegate: TaskCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

protocol TaskCellDelegate{
    func deleteButton(cell: TaskCell)
}
