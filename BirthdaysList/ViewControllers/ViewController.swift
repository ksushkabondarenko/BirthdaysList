import UIKit
import SPConfetti

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Actions
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private var users = [Person]() {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    // MARK: - API
    // MARK: - Helpers

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addSetUps()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let persons = CoreDataManager.instance.getperson() else { return }
        users = persons
    }

    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(mainTableView)
        mainTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    private func addSetUps() {
        // navigationController
        title = "Birthdays List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = AppColor.backgroundColor2
        //view
        view.backgroundColor = AppColor.backgroundColor2
        // mainTableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = AppColor.backgroundColor2
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            let person = users[indexPath.row]
            cell.set(person: person)
            return cell
        }
        return UITableViewCell()
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            mainTableView.beginUpdates()
            mainTableView.deleteRows(at: [indexPath], with: .automatic)
            users.remove(at: indexPath.row) //Remove element from your array
            mainTableView.endUpdates()
        }
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            users.remove(at: indexPath.row)
//            self.tableView.reloadData()
//            //tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SPConfetti.startAnimating(.centerWidthToDown, particles: [.triangle, .arc], duration: 2)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let detailScreenVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
//            detailScreenVC.modalPresentationStyle = .formSheet
//            detailScreenVC.movieInfo = moviesInfo[indexPath.item]
//            navigationController?.pushViewController(detailScreenVC, animated: true)
        }
 //   }
}
