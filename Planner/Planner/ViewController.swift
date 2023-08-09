//
//  ViewController.swift
//  Planner
//
//  Created by Gamze Akyüz on 10.04.2023.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var exam  = [Planner]()
    
    let dateFormater = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormater.dateFormat = "dd.MM.yyyy , HH:mm"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newPlanner"), object: nil)
    }
    
    @objc func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Planner.fetchRequest() as NSFetchRequest<Planner>
        do {
            exam = try context.fetch(fetchRequest)
            print(exam)
        } catch let error {
            print("Error context :  \(error).") }
        tableView.reloadData()
    }
    func saveContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! TableViewCell
        cell.examTitle.text = exam[indexPath.row].title ?? ""
        cell.examLocationTitle.text = exam[indexPath.row].location ?? ""
        cell.examSubjectTitle.text = exam[indexPath.row].subject ?? ""
        cell.dateTitle.text = dateFormater.string(from: exam[indexPath.row].date!)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exam.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = exam[indexPath.row]
            let alert = UIAlertController(title: "Emin Misiniz?", message: "Silmek istediğine emin misin", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Hayır", style: .cancel)
            let deleteAction = UIAlertAction(title: "Evet", style: .destructive) { _ in
                context.delete(entity)
                self.exam.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.saveContext()
                
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            present(alert, animated: true)
         }
    }

}
