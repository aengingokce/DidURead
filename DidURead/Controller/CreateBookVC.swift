//
//  CreateBookVC.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 17.10.2021.
//

import UIKit

class CreateBookVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var txtNumberOfPages: UITextField!
    
    var nameOfBook : String!
    var readingPeriod : ReadingPeriod!
    
    func collectData(name : String, period : ReadingPeriod) {
        self.nameOfBook = name
        self.readingPeriod = period
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.cornerRadius = 20
        btnCreate.layer.cornerRadius = 20
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnCreateClicked(_ sender: Any) {
        if txtNumberOfPages.text != "" {
            if Int(txtNumberOfPages.text!)! > 0 {
                self.saveData { finished in
                    if finished {
                        dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func saveData(completionHandler : (_ finished : Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let book = Book(context: managedContext)
        book.nameOfBook = nameOfBook
        book.readingPeriod = readingPeriod.rawValue
        book.numberOfPages = Int32(txtNumberOfPages.text!)!
        book.currentPage = Int32(0)
        
        do {
            try managedContext.save()
            completionHandler(true)
        } catch {
            debugPrint(error.localizedDescription)
            completionHandler(false)
        }
        
    }
    
}
