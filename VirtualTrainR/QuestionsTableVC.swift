//
//  QuestionsVC.swift
//  VirtualTrainr
//
//  Created by Anthony Ma on 2017-06-15.
//  Copyright © 2017 Apptist. All rights reserved.
//
/*
import Foundation
import UIKit

enum SelectionsFor {
    case activity
    case days
    case time
    case travel
}

enum QuestionsFor {
    case client
    case trainer
}

class QuestionsTableVC: RegisterVC, UITableViewDelegate, UITableViewDataSource {
    
    // view model
    var tableView: UITableView!
    var nextBtn: NextBtn!
    
    /*
    // data
    var activities = [Activities.yoga.rawValue, Activities.body.rawValue, Activities.endurance.rawValue, Activities.weightLoss.rawValue, Activities.healthier.rawValue]
    var daysOfWeek = [DayOfWeek.sunday.rawValue, DayOfWeek.monday.rawValue, DayOfWeek.tuesday.rawValue, DayOfWeek.wednesday.rawValue, DayOfWeek.thursday.rawValue, DayOfWeek.friday.rawValue, DayOfWeek.saturday.rawValue]
    var timeRange = [TimeRange.morning.rawValue, TimeRange.lateMorning.rawValue, TimeRange.afternoon.rawValue, TimeRange.lateAfternoon.rawValue, TimeRange.evening.rawValue]
    var travelRange = [TravelRange.trainerMeet.rawValue, TravelRange.fiveToNineteen.rawValue, TravelRange.twentyOrMore.rawValue, TravelRange.virtual.rawValue]
    */
    
    // data model
    var items: [String]?
    
    // set view
    var questions: QuestionsFor?
    var selection: SelectionsFor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial selections to activities
        self.items = activities
        
        // set inital view is activities
        self.selection = SelectionsFor.activity
        
        // tableview
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.register(SelectionCells.self, forCellReuseIdentifier: "selections")
        tableView.isScrollEnabled = false // disable scroll
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor).isActive = true // title label from super class
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.71).isActive = true
        
        nextBtn = NextBtn()
        nextBtn.isHidden = true
        nextBtn.layer.cornerRadius = 30
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
//        nextBtn.animateRadius(scale: 1.2, soundOn: false)
//        nextBtn.animateWithNewImage(scale: 1.2, soundOn: false, image: #imageLiteral(resourceName: "forward_ic.png"))
        self.view.addSubview(nextBtn)
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: -20).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // set title of view
        self.updateTitle()
    }
    
    // MARK: - Table View Delegate
    
    // select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // check if next button should show
        self.checkSelectedCells()
    }
    
    // deselect row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // check if next button should show
        self.checkSelectedCells()
    }
    
    // set height of each row depending on selections (tableview height divided by number of items)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfItems = CGFloat(self.updateNumberOfItems())
        let statusBarOffset = 20 / numberOfItems
        let cellHeight = tableView.frame.height / numberOfItems - statusBarOffset
        return cellHeight
    }
    
    // MARK: - Table View DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.updateNumberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selections", for: indexPath) as! SelectionCells
        
        // configure cell
        cell.backgroundColor = UIColor.clear
        cell.selectionLbl.text = self.items?[indexPath.row]
        return cell
    }
    
    // MARK: - Table View Title and Data Management
    
    // update number of items in model
    func updateNumberOfItems() -> Int {
        if let count = self.items?.count {
            return count
        }
        return 0
    }
    
    // update title
    func updateTitle() {
        switch (self.selection)! {
        case .activity:
            if questions == QuestionsFor.client {
                self.setTitleString(str: "What activities are you interested in?")
            }
            self.setTitleString(str: "What activities do you specialize in?")
        case .days:
            self.setTitleString(str: "What days are you available?")
        case .time:
            self.setTitleString(str: "What time are you available?")
        case .travel:
            self.setTitleString(str: "How far are you willing to travel?")
        }
    }
    
    // check if any selected cells
    func checkSelectedCells() {
        if (self.tableView.indexPathsForSelectedRows) != nil {
            self.nextBtn.isHidden = false
        }
        else {
            self.nextBtn.isHidden = true
        }
    }
    
    // MARK: - Next Button Function
    func nextBtnPressed() {
        switch (self.selection)! { // set next set of selections
        case .activity:
            // save selections
            self.saveSelections()
            // move to next set of selections (days)
            self.selection = SelectionsFor.days
            // update title
            self.updateTitle()
            // update new data model
            self.items = daysOfWeek
            self.tableView.reloadData()
            // next btn handle (hidden toggle)
            self.checkSelectedCells()
        case .days:
            self.saveSelections()
            self.selection = SelectionsFor.time
            self.updateTitle()
            self.items = timeRange
            self.tableView.allowsMultipleSelection = true
            self.tableView.reloadData()
            self.checkSelectedCells()
        case .time:
            self.saveSelections()
            self.selection = SelectionsFor.travel
            self.updateTitle()
            self.items = travelRange
            self.tableView.allowsMultipleSelection = false
            self.tableView.reloadData()
            self.checkSelectedCells()
        case .travel:
            self.saveSelections()
            self.checkSelectedCells()
            let logInSelection = LoginSelection()
            self.present(logInSelection, animated: true, completion: nil)
        }
    }
    
    // MARK: - Back Btn of View
    override func backBtnPressed() { // set previous selections
        switch (self.selection)! {
        case .days:
            // remove saved selections
            self.removeSelections()
            // move back to last set of selections (activities)
            self.selection = SelectionsFor.activity
            // update title
            self.updateTitle()
            // update new data model
            self.items = activities
            self.tableView.allowsMultipleSelection = true
            self.tableView.reloadData()
            // next btn handle (hidden toggle)
            self.checkSelectedCells()
        case .time:
            self.removeSelections()
            self.selection = SelectionsFor.days
            self.updateTitle()
            self.items = daysOfWeek
            self.tableView.reloadData()
            self.checkSelectedCells()
        case .travel:
            self.removeSelections()
            self.checkSelectedCells()
            self.selection = SelectionsFor.time
            self.updateTitle()
            self.items = timeRange
            self.tableView.reloadData()
        default:
            self.removeSelections()
            self.checkSelectedCells()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Save and Remove
    func saveSelections() {
        switch (self.selection)! {
        case .activity:
            let selected = self.tableView.indexPathsForSelectedRows!
            var chosenActivity = [String]()
            for indexPath in selected {
                let row = indexPath.row
                chosenActivity.append(self.activities[row])
            }
            if questions == QuestionsFor.client {
                self.userDefaults.set(chosenActivity, forKey: "UserActivities")
                break
            }
            self.userDefaults.set(chosenActivity, forKey: "TrainerActivities")
        case .days:
            let selected = self.tableView.indexPathsForSelectedRows!
            var chosenDays = [String]()
            for indexPath in selected {
                let row = indexPath.row
                chosenDays.append(self.daysOfWeek[row])
            }
            if questions == QuestionsFor.client {
                self.userDefaults.set(chosenDays, forKey: "UserDays")
                break
            }
            self.userDefaults.set(chosenDays, forKey: "TrainerDays")
        case .time:
            let selected = self.tableView.indexPathsForSelectedRows!
            var chosenTimes = [String]()
            for indexPath in selected {
                let row = indexPath.row
                chosenTimes.append(self.timeRange[row])
            }
            if questions == QuestionsFor.client {
                self.userDefaults.set(chosenTimes, forKey: "UserTimes")
                break
            }
            self.userDefaults.set(chosenTimes, forKey: "TrainerTimes")
        case .travel:
            let selected = self.tableView.indexPathForSelectedRow!.row
            let selectedRange = self.travelRange[selected]
            if questions == QuestionsFor.client {
                self.userDefaults.set(selectedRange, forKey: "UserTravel")
                break
            }
            self.userDefaults.set(selectedRange, forKey: "TrainerTravel")
        }
    }
    
    func removeSelections() {
        switch (self.selection)! {
        case .activity:
            if questions == QuestionsFor.client {
                self.userDefaults.removeObject(forKey: "UserActivities")
                break
            }
            self.userDefaults.removeObject(forKey: "TrainerActivities")
        case .days:
            if questions == QuestionsFor.client {
                self.userDefaults.removeObject(forKey: "UserDays")
                break
            }
            self.userDefaults.removeObject(forKey: "TrainerDays")
        case .time:
            if questions == QuestionsFor.client {
                self.userDefaults.removeObject(forKey: "UserTimes")
                break
            }
            self.userDefaults.removeObject(forKey: "TrainerTimes")
        case .travel:
            if questions == QuestionsFor.client {
                self.userDefaults.removeObject(forKey: "UserTravel")
                break
            }
            self.userDefaults.removeObject(forKey: "TrainerTravel")
        }
    }
    
}

// MARK: Selection Cell
class SelectionCells: UITableViewCell {
    
    // View
    var selectionLbl: VTLabel!
    var viewOverlay: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.clear
        
        // selection label displaying text
        selectionLbl = VTLabel()
        selectionLbl.backgroundColor = UIColor.clear
        selectionLbl.textAlignment = .center
        selectionLbl.textColor = UIColor.white
        selectionLbl.font = self.createFontWithSize(fontName: standardFont, size: 18.0)
        self.contentView.addSubview(selectionLbl)
        selectionLbl.translatesAutoresizingMaskIntoConstraints = false
        selectionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        selectionLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        selectionLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        selectionLbl.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        // tint effect on selections
        viewOverlay = UIView()
        viewOverlay.backgroundColor = UIColor.white
        viewOverlay.alpha = 0.2
        self.contentView.addSubview(viewOverlay)
        viewOverlay.translatesAutoresizingMaskIntoConstraints = false
        viewOverlay.leadingAnchor.constraint(equalTo: self.selectionLbl.leadingAnchor).isActive = true
        viewOverlay.topAnchor.constraint(equalTo: self.selectionLbl.topAnchor).isActive = true
        viewOverlay.widthAnchor.constraint(equalTo: self.selectionLbl.widthAnchor).isActive = true
        viewOverlay.heightAnchor.constraint(equalTo: self.selectionLbl.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Next Button
class NextBtn: VTButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.setImage(#imageLiteral(resourceName: "nextBtnArrow.png"), for: .normal) // nextBtnArrow.png
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
*/
