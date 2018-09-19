//
//  ViewController.swift
//  dbworks
//
//  Created by Ishmam Islam on 21/7/18.
//  Copyright © 2018 Ishmam Islam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var utableview: UITableView!
    
    var students : [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        utableview.delegate = self
        utableview.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        self.students = self.fetchData()
        self.utableview.reloadData()
    }
    
    func fetchData() -> [Student] {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let students = try managedContext.fetch(Student.fetch())
            return students
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    @IBAction func addStudent(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Student", message: "", preferredStyle: .alert)
        alertController.addTextField {(textField: UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        alertController.addTextField{(textField: UITextField!) -> Void in
            textField.placeholder = "Phone No"
        }
        alertController.addTextField{(textField: UITextField!) -> Void in
            textField.placeholder = "Address"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let name = alertController.textFields![0] as UITextField
            let phone = alertController.textFields![1] as UITextField
            let address = alertController.textFields![2] as UITextField
            
            self.addNewStudent(name: name.text!, phone: phone.text!, address: address.text!)
            self.students = self.fetchData()
            self.utableview.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func delete(_ student: Student) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(student)
        self.save()
    }
    
    func save(){
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch {
            print("Failed Saving")
        }
    }
    
    func addNewStudent(name: String, phone: String, address: String){
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: Student.entityName, in: managedContext) else {return}
        let student = Student(entity: entity, insertInto: managedContext)
        student.name = name
        student.phone = phone
        student.address = address
        self.save()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = utableview.dequeueReusableCell(withIdentifier: "StudentTableViewCell" , for: indexPath) as! StudentTableViewCell
        
        let student = students[indexPath.row]
        cell.name.text = student.name
        cell.phoneno.text = student.phone
        cell.address.text = student.address
        cell.id.text = String(student.id)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Deleted")
//            self.delete(self.students[indexPath.row])
//            self.students.remove(at:indexPath.row)
//            self.utableview.beginUpdates()
//            self.utableview.deleteRows(at: [indexPath], with: .automatic)
//            self.utableview.endUpdates()
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            let alertController = UIAlertController(title: "Edit Student", message: "", preferredStyle: .alert)
            alertController.addTextField{ (textField: UITextField!) -> Void in
                textField.text = self.students[indexPath.row].name
            }
            alertController.addTextField{ (textField: UITextField!) -> Void in
                textField.text = self.students[indexPath.row].phone
            }
            alertController.addTextField{ (textField: UITextField!) -> Void in
                textField.text = self.students[indexPath.row].address
            }
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                let name = alertController.textFields![0] as UITextField
                let phone = alertController.textFields![1] as UITextField
                let address = alertController.textFields![2] as UITextField
                self.students[indexPath.row].name = name.text
                self.students[indexPath.row].phone = phone.text
                self.students[indexPath.row].address = address.text
                self.save()
                self.utableview.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.delete(self.students[indexPath.row])
            self.students.remove(at:indexPath.row)
            self.utableview.beginUpdates()
            self.utableview.deleteRows(at: [indexPath], with: .automatic)
            self.utableview.endUpdates()
        })
        
        return [deleteAction, editAction]
    }
    
    

}

