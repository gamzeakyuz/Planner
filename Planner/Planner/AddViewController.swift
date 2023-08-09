//
//  AddViewController.swift
//  Planner
//
//  Created by Gamze Akyüz on 10.04.2023.
//

import UIKit
import CoreData
import UserNotifications

class AddViewController: UIViewController{
    
    var exam  = [Planner]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var examDatePicker: UIDatePicker!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var saveButtonisEnabled: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!

    let notification = NotificationHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateView.layer.cornerRadius = 10.0
        contentView.layer.cornerRadius = 10.0

        examDatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func saveButton(_ sender: Any){
        
        if titleTextField.text != "" && subjectTextField.text != "" && subjectTextField.text != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newExam = NSEntityDescription.insertNewObject(forEntityName: "Planner", into: context)

            newExam.setValue(UUID(), forKey: "id")
            newExam.setValue(titleTextField.text!, forKey: "title")
            newExam.setValue(subjectTextField.text!, forKey: "subject")
            newExam.setValue(examDatePicker.date, forKey: "date")
            newExam.setValue(locationTextField.text!, forKey: "location")

            do {
                try context.save()
                notification.sendNotification(for: newExam as! Planner)
                dismiss(animated: true, completion: nil)
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name("newPlanner"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
           Alert()
        }
        
    }
    
    func Alert() {
            let alert = UIAlertController(title: "Boş Alan Bıraktınız", message: "Boş alan bırakmadığınıza emin olunuz.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Kapat", style: .default) { (action) in
                print("butona tıklandı")
            }
            alert.addAction(okButton)
            present(alert, animated: true) {
                print("alert kapatıldı")
            }
        }
    
    @IBAction func closeButton(_ sender: Any){
        self.context.rollback()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        // Seçilen tarih ve saat değerini al
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy , HH:mm"
        let selectedDate = dateFormatter.string(from: sender.date)
        
        // Seçilen tarih ve saat değerini etikete ekle
        dateTimeLabel.text = "Tarih ve Saat : " + selectedDate
    }
    
    
    



}
