//
//  ViewController.swift
//  ResizingTextCellTester
//
//  Created by Daniel (張道博) on 1/5/16.
//  Copyright © 2016 ikiApps.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    var cellH = 50 as CGFloat
    var cellW = 100 as CGFloat

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let frame = view.bounds
        tableView.frame = CGRectMake(frame.origin.x, frame.origin.y + 64, frame.size.width, frame.size.height)
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return cellH
        } else {
            return 50
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
            cell.myTextView.delegate = self
            cell.myTextView.backgroundColor = UIColor.lightGrayColor()
            cell.myTextView.frame = cell.bounds
            cell.layer.borderColor = UIColor.redColor().CGColor
            cell.layer.borderWidth = 1
            cellW = cell.bounds.size.width
            self.textViewDidChange(cell.myTextView)

            return cell
        }

        let newCell = tableView.dequeueReusableCellWithIdentifier("MyOtherCell", forIndexPath: indexPath) as! MyOtherCell
        newCell.backgroundColor = UIColor.blueColor()
        return newCell
    }

    func textViewDidChange(textView: UITextView) {

        let frame = textView.frame
        textView.frame = CGRectMake(frame.origin.x,frame.origin.y,cellW,cellH)

        textView.sizeToFit()

        let height = textView.sizeThatFits(CGSizeMake(textView.frame.size.width, CGFloat.max)).height
        cellH = height

        textView.frame = CGRectMake(frame.origin.x,frame.origin.y,cellW,cellH)
        textView.contentSize.height = height

        cellH = textView.frame.height

        tableView.beginUpdates()
        tableView.endUpdates()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

class MyTextView: UITextView {
    
}

class MyCell: UITableViewCell {
    @IBOutlet weak var myTextView: MyTextView!
}

class MyOtherCell: UITableViewCell {

}

