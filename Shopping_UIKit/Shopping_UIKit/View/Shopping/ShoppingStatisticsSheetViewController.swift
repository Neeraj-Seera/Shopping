//
//  ShoppingStatisticsSheetViewController.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import UIKit

class ShoppingStatisticsSheetViewController: UIViewController {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var countThreeLabel: UILabel!
    @IBOutlet weak var countTwoLabel: UILabel!
    @IBOutlet weak var countOneLabel: UILabel!
    private var OccuDict = [String : Int]()
    private var totalCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        self.headlineLabel.text =  Strings.countDescription + String(totalCount)
        let sortedOccurrences = OccuDict.sorted { $0.value > $1.value }
        if sortedOccurrences.count >= 3 {
            let firstEntry = sortedOccurrences[0]
            let secondEntry = sortedOccurrences[1]
            let thirdEntry = sortedOccurrences[2]
            self.countOneLabel.text = "\(firstEntry.key) = \(firstEntry.value)"
            self.countTwoLabel.text = "\(secondEntry.key) = \(secondEntry.value)"
            self.countThreeLabel.text = "\(thirdEntry.key) = \(thirdEntry.value)"
        } else {
            self.countOneLabel.text = Strings.insufficientData
            self.countTwoLabel.text =  Strings.empty
            self.countThreeLabel.text = Strings.empty
        }
    }
    
    func configure(totalCount: Int, topOccurrences: [Character: Int]) {
        self.totalCount = totalCount
        let topOccurrences = topOccurrences
        for (character, count) in topOccurrences {
            if let existingCount = OccuDict[String(character)] {
                OccuDict[String(character)] = existingCount + count
            } else {
                OccuDict[String(character)] = count
            }
        }
    }
}
