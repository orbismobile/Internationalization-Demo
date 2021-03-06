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
    
    private struct AlertMessages {
        struct Box {
            static let titleEgreso = NSLocalizedString("Egreso", comment: "Titulo del alert")
            static let titleIngresar = NSLocalizedString("Ingresar", comment: "Titulo del alert")
            static let messages = NSLocalizedString("Ingrese un monto", comment: "Mensaje en el alert")
            static let btnIngresar = NSLocalizedString("IngresarBtn", comment: "texto boton ingreso")
            static let btnCancelar = NSLocalizedString("Cancelar", comment: "Boton cancelar")
        }
    }
    

    @IBAction func minusMoney(sender: AnyObject) {
        self.showAlertView( AlertMessages.Box.titleEgreso, factor:-1)
    }

    
    @IBAction func addMoney(sender: AnyObject) {
        self.showAlertView(AlertMessages.Box.titleIngresar, factor: 1)
    }
    
    
    // NSLocalizedString, me permite hacer los cambios para diferentes idiomas, las traducciones estan en los archivos .strings
    

    
    func showAlertView(titleAlert: String, factor:Double) -> Void {
        let alertViewController = UIAlertController(title: titleAlert, message: AlertMessages.Box.messages, preferredStyle: .Alert) as UIAlertController
        let addAction = UIAlertAction(title: AlertMessages.Box.btnIngresar, style: .Default) { (UIAlertAction) -> Void in
            
            let textField = alertViewController.textFields![0] as UITextField
            let newValue = Double(textField.text!)! * factor
            
            self.moneyData.append(newValue)
            if factor == -1 {
                self.outMoneyData.append(newValue)
            }else{
                self.inMoneyData.append(newValue)
            }
            
            self.tableView.reloadData()
            self.totalMoney.text = "\(self.sumMoney())"
        }
        let cancelAction = UIAlertAction(title: AlertMessages.Box.btnCancelar, style: .Cancel, handler: nil)
        alertViewController.addAction(addAction)
        alertViewController.addAction(cancelAction)
        alertViewController.addTextFieldWithConfigurationHandler{ (UITextField) -> Void in }
        self.presentViewController(alertViewController, animated: true) { () -> Void in }
    }
    
    
    func reloadTableView() -> Void {
        print("in \(self.inMoneyData)")
        print("out \(self.outMoneyData)")
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

