import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Outlets
    // MARK: - Actions
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let separatorView = UIView()
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton()
    private let askTimeLabel = UILabel()
    private let timeTextField = UITextField()
    
    
    // MARK: - API
    
    // MARK: - Helpers

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setUps()
        setInputView()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubViews(nameTextField, surnameTextField, separatorView, datePicker, saveButton, askTimeLabel, timeTextField)
    }
    private func addConstraints() {
        //nameTextField
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //surnameTextField
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //separatorView
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 15).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //datePicker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: separatorView.topAnchor, constant: 15).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 194).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        //askTimeLabel
        askTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        askTimeLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true
        askTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        //askTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //saveButton
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: askTimeLabel.bottomAnchor, constant: 20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //timeTextField
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        timeTextField.leadingAnchor.constraint(equalTo: askTimeLabel.trailingAnchor, constant: 10).isActive = true
        timeTextField.topAnchor.constraint(equalTo: askTimeLabel.topAnchor).isActive = true
        timeTextField.heightAnchor.constraint(equalTo: askTimeLabel.heightAnchor).isActive = true
        timeTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func setUps() {
        // navigationController
        title = "New Info"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = AppColor.backgroundColor2
        //view
        view.backgroundColor = AppColor.backgroundColor2
        //nameTextField
        nameTextField.placeholder = "  Enter name"
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 10
        nameTextField.textAlignment = .justified
        nameTextField.backgroundColor = AppColor.textFieldColor
        //surnameTextField
        surnameTextField.placeholder = "  Enter surname"
        surnameTextField.backgroundColor = AppColor.textFieldColor
        surnameTextField.layer.cornerRadius = 10
        surnameTextField.textAlignment = .justified
        //separatorView
        separatorView.backgroundColor = .systemGray4
        //datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        //askTimeLabel
        askTimeLabel.text = "Enter the time to be notified:"
        askTimeLabel.textAlignment = .left
        askTimeLabel.font = .systemFont(ofSize: 22, weight: .regular)
        //saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        saveButton.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
        saveButton.backgroundColor = .systemGray4
        saveButton.layer.cornerRadius = 10
        //timeTextField
        timeTextField.placeholder = "00:00"
        timeTextField.font = .systemFont(ofSize: 22, weight: .regular)
    }
    
    // MARK: - Actions
    private func setInputView() {
        timeTextField.setInPutView(target: self, selector: #selector(saveTapped))
    }
    
    @objc private func saveTapped() {
        if let datePicker = timeTextField.inputView as? UIDatePicker
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "HH:mm"
            timeTextField.text = dateFormatter.string(from: datePicker.date)
            
        }
        timeTextField.resignFirstResponder()
    }
    
    @objc private func saveButtonClick() {
        if nameTextField.text != "" {
            let name = nameTextField.text ?? ""
            let surname = surnameTextField.text ?? ""
            let dateformatter = DateFormatter()
            let date = datePicker.date
//            dateformatter.dateFormat = "dd.MM.yy"
//            let date = dateformatter.string(from: datePicker.date)
            let person = Person(name: name, surname: surname, date: date)
            CoreDataManager.instance.savePerson(person)
            navigationController?.popViewController(animated: true)
        } else {
            showAllert("Fill name!")
        }
    }
    
    // MARK: - Helpers
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
