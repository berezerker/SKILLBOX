import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBAction func changeName(_ sender: Any) {
        PersistanceUser.shared.userName = nameTextField.text!
        nameTextField.text = "Добавлено!"
        nameTextField.textColor = UIColor.green
    }
    @IBAction func changeSurname(_ sender: Any) {
        PersistanceUser.shared.userSurname = surnameTextField.text!
        surnameTextField.text = "Добавлено!"
        surnameTextField.textColor = UIColor.green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = PersistanceUser.shared.userName{
        nameLabel.text = name
        }
        if let surname = PersistanceUser.shared.userSurname{
        surnameLabel.text = surname
        }
}
}

