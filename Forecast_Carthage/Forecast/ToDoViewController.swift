
import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newToDoField: UITextField!
    @IBAction func addNewTask(_ sender: Any) {
        PersistanceTask.shared.addTask(task: newToDoField.text!, id: PersistanceTask.shared.allTasks().count + 1)
        newToDoField.text = ""
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        PersistanceTask.shared.updateData()
        
    }
    
    func deleteButtonWasTappedIn(cell: TaskCell) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [self.tableView.indexPath(for: cell)!], with: .left)
        tableView.endUpdates()
    }
    

}

extension ToDoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersistanceTask.shared.allTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.numberTaskLabel.text = "\(indexPath.row + 1)"
        cell.taskText.text = PersistanceTask.shared.allTasks()[indexPath.row].task
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    
}

extension ToDoViewController: TaskCellDelegate{
    func deleteButton(cell: TaskCell) {
        let task = Task()
        task.task = cell.taskText.text!
        task.id = cell.tag + 1
        PersistanceTask.shared.deleteTask(task)
        deleteButtonWasTappedIn(cell: cell)
    }
}
