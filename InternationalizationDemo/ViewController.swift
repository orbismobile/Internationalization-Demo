//
//  ViewController.swift
//  InternationalizationDemo
//
//  Created by Erik Flores on 1/29/16.
//  Copyright © 2016 Orbis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var moneyData = [Double]()
    var inMoneyData = [Double]()
    var outMoneyData = [Double]()
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var segementView: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.segementView.addTarget(self, action: Selector("reloadTableView"), forControlEvents: .ValueChanged)
    }
    

    @IBAction func minusMoney(sender: AnyObject) {
        self.showAlertView("Egreso", dataStore: self.outMoneyData)
    }

    
    @IBAction func addMoney(sender: AnyObject) {
        self.showAlertView("Ingresar",dataStore: self.inMoneyData)
    }
    
    func showAlertView(title: String, var dataStore:[Double]) -> Void {
        let alertViewController = UIAlertController(title: title, message: "Ingrese un monto", preferredStyle: .Alert) as UIAlertController
        let addAction = UIAlertAction(title: "Ingresar", style: .Default) { (UIAlertAction) -> Void in
            
            let textField = alertViewController.textFields![0] as UITextField
            let newValue = Double(textField.text!)!
            
            self.moneyData.append(newValue)
            dataStore.append(newValue)
            
            self.tableView.reloadData()
            self.totalMoney.text = "S/. \(self.sumMoney())"
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        alertViewController.addAction(addAction)
        alertViewController.addAction(cancelAction)
        alertViewController.addTextFieldWithConfigurationHandler{ (UITextField) -> Void in }
        self.presentViewController(alertViewController, animated: true) { () -> Void in }
    }
    
    
    func reloadTableView() -> Void {
        self.tableView.reloadData()
    }
    
    
    func sumMoney() -> Double {
        var allMoney:Double = 0
        for item in self.moneyData {
            allMoney = allMoney + item
        }
        return allMoney
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segementView.selectedSegmentIndex == 0 {
            return self.inMoneyData.count
        } else {
            return self.outMoneyData.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellTemplate")!
        var moneyItem = ""
        if self.segementView.selectedSegmentIndex == 0{
             moneyItem = "\(self.inMoneyData[indexPath.row])"
        } else {
             moneyItem = "\(self.outMoneyData[indexPath.row])"
        }
        cell.textLabel?.text = moneyItem
        
        return cell
        
    }
}

