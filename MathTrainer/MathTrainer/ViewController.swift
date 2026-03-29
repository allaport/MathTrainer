//
//  ViewController.swift
//  MathTrainer
//
//  Created by Macbook Pro on 11/13/24.
//

import FirebaseFirestore
import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            return "addCount"
        case .subtract:
            return "subtractCount"
        case .multiply:
            return "multiplyCount"
        case .divide:
            return "divideCount"
        }
    }
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var subtractLabel: UILabel!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var divideLabel: UILabel!
    
    // MARK: - Properties
    private var addScore: Int = 0
    private var subtractScore: Int = 0
    private var multiplyScore: Int = 0
    private var divideScore: Int = 0
    
    private var selectedType: MathTypes = .add
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        updateScoreLabels()
        setCountLabels()
    }
    
    // MARK: - Actions
    @IBAction func ButtonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            addLabel.text = "-"
            subtractLabel.text = "-"
            multiplyLabel.text = "-"
            divideLabel.text = "-"
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
        
        //        if let destinationVC = segue.destination as? TrainViewController {
        //            destinationVC.onScoreUpdate = { [weak self] score in
        //                guard let self else { return }
        //                switch destinationVC.type {
        //                case .add:
        //                    addScore = score
        //                case .subtract:
        //                    subtractScore = score
        //                case .multiply:
        //                    multiplyScore = score
        //                case .divide:
        //                    divideScore = score
        //                }
        //                updateScoreLabels()
        //            }
        //        }
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count =  UserDefaults.standard.object(forKey: key) as? Int else { return }
            let stringValue = String(count)
            
            switch type {
            case .add:
                addLabel.text = stringValue
            case .subtract:
                subtractLabel.text = stringValue
            case .multiply:
                multiplyLabel.text = stringValue
            case .divide:
                divideLabel.text = stringValue
            }
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button  in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    private func updateScoreLabels() {
        addLabel.text = "Score: \(addScore)"
        subtractLabel.text = "Score: \(subtractScore)"
        multiplyLabel.text = "Score: \(multiplyScore)"
        divideLabel.text = "Score: \(divideScore)"
    }
}

