//
//  SixthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class SixthViewController: ExerciseViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var rows = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 6"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.exerciseView.addSubview(tableView)
        self.tableView.frame = self.exerciseView.frame
        self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController!.navigationBar.frame), 0, 0, 0)
        self.tableView.autoresizingMask = self.exerciseView.autoresizingMask
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        
        /* TODO:
        The table view cells on this screen are blank.
        
        Add a label to each cell that is green and centered, and have its text say “Row {X}” (X is the row number of the cell). The tableview should rotate correctly. Use Autolayout.
        */
        
        // Remove any pre-existing labels
        for subview in cell!.subviews {
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }

        // Create new label with correct row title
        var myLabel = UILabel()
        myLabel.backgroundColor = UIColor.greenColor()
        myLabel.text = "Row \(indexPath.row)"
        myLabel.textAlignment = .Center
        
        myLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        cell?.addSubview(myLabel)
            
        // Create constraints for label position
        let labelCenterX = NSLayoutConstraint(item: myLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: cell,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let labelCenterY = NSLayoutConstraint(item: myLabel,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: cell,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 0)
        
        // Add constraints to cell
        cell?.addConstraints([labelCenterX,labelCenterY])
        
        return cell!
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
