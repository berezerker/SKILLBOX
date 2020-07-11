
import UIKit
import CoreData

class ToDoCoreDataViewController: UIViewController {
    
    @IBOutlet weak var nameToDoField: UITextField!
    var tasks: [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    var container: NSPersistentContainer!

    @IBAction func addNew(_ sender: Any) {
        let text = nameToDoField.text!
        self.save(text, NSUUID())
        nameToDoField.text = ""
        tableView.reloadData()
    }
    
    func save(_ task: String, _ id: NSUUID) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext

      let entity = NSEntityDescription.entity(forEntityName: "TaskCore", in: managedContext)!
      
      let taskObject = NSManagedObject(entity: entity, insertInto: managedContext)

        taskObject.setValue(task, forKeyPath: "task")
        taskObject.setValue(id, forKey: "id")

      do {
        try managedContext.save()
        tasks.append(taskObject)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "TaskCore")
      
      //3
      do {
        tasks = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    func deleteButtonWasTappedIn(cell: TaskCoreDataCell) {
        tableView.deleteRows(at: [self.tableView.indexPath(for: cell)!], with: .left)
        tableView.reloadData()
    }
    
    func deleteCoreData(id: NSUUID){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "TaskCore")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let object = test[0] as! NSManagedObject
            managedContext.delete(object)
            do{
                try managedContext.save()
            } catch{
                print(error)
            }
        }
        catch{
            print(error)
        }
        let fetchRequestReload =
          NSFetchRequest<NSManagedObject>(entityName: "TaskCore")
        
        //3
        do {
          tasks = try managedContext.fetch(fetchRequestReload)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}

extension ToDoCoreDataViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCoreDataCell") as! TaskCoreDataCell
        cell.numberTaskLabel.text = "\(indexPath.row + 1)"
        cell.taskText.text = tasks[indexPath.row].value(forKeyPath: "task") as? String
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
}

extension ToDoCoreDataViewController: TaskCoreDataCellDelegate{
    func deleteButton(cell: TaskCoreDataCell) {
        let task = tasks[cell.tag]
        deleteCoreData(id: task.value(forKey: "id") as! NSUUID)
        deleteButtonWasTappedIn(cell: cell)
    }
    
}

