import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Private
    private let mainView: UIView = UIView()
    private let infoStackView: UIStackView = UIStackView()
    private var nameLabel: UILabel = UILabel()
    private var dataLabel: UILabel = UILabel()

    //MARK: - LIfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addAllSubviews()
        addConstraints()
        addSetupsUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    func set(person: Person) {
        nameLabel.text = "\(person.name) \(person.surname)"
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yy"
        dataLabel.text = dateformatter.string(from: person.date)
    }
    
    // MARK: Private
    private func addConstraints() {
        addMainViewConstraint()
        addInfoStackView()
    }
    private func addMainViewConstraint() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    private func addInfoStackView() {
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    // MARK: Private
    private func addAllSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(dataLabel)
    }
    private func addSetupsUI() {
        addCellSetUp()
        addMainViewUI()
        addInfoStackViewUI()
        addNameLabelUI()
        addDataLabelUI()
    }
    private func addCellSetUp() {
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = AppColor.backgroundColor2
    }
    private func addMainViewUI() {
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowRadius = 4
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        
    }
    private func addInfoStackViewUI() {
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .fillEqually
    }
    private func addNameLabelUI() {
        nameLabel.font = .systemFont(ofSize: 22, weight: .regular)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
    }
    private func addDataLabelUI() {
        dataLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dataLabel.text = "8.9/10"
        dataLabel.textAlignment = .center
        dataLabel.textColor = .black
    }
    
    
}
