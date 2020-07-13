
import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newToDoField: UITextField!
    @IBAction func addNewTask(_ sender: Any) {
        PersistanceTask.shared.addTask(task: newToDoField.text!, id: NSUUID())
        newToDoField.text = ""
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func deleteButtonWasTappedIn(cell: TaskCell) {
        tableView.deleteRows(at: [self.tableView.indexPath(for: cell)!], with: .left)
        tableView.reloadData()
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
        cell.delegate = self
        return cell
    }
    
    
}

extension ToDoViewController: TaskCellDelegate{
    func deleteButton(cell: TaskCell) {
        let task = PersistanceTask.shared.allTasks()[tableView.indexPath(for: cell)!.row]
        PersistanceTask.shared.deleteTask(task.id)
        deleteButtonWasTappedIn(cell: cell)
    }
}
