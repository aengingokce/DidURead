//
//  ViewController.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 13.10.2021.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ListOfBooksVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var listOfBooks : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDatas()
    }
    
    func loadDatas() {
        self.loadData { complete in
            if complete {
                if listOfBooks.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
        tableView.reloadData()
    }

    @IBAction func btnAddBook(_ sender: UIButton) {
        guard let addBookVC = storyboard?.instantiateViewController(withIdentifier: "AddBookVC") else { return }
        newPresent(addBookVC)
    }
    
}

extension ListOfBooksVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as? BookCell else { return UITableViewCell() }
        let bookFromList = listOfBooks[indexPath.row]
        cell.setViewCell(book: bookFromList)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete Book") { action, indexPath in
            self.removeData(indexPath: indexPath)
            self.loadDatas()
        }
        deleteAction.backgroundColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
        
        let updateCurrentPage = UITableViewRowAction(style: .normal, title: "+30") { action, indexPath in
            self.readingBook(indexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        updateCurrentPage.backgroundColor = UIColor(red: 255/255, green: 181/255, blue: 53/255, alpha: 1)
        return [deleteAction, updateCurrentPage]
    }
}

extension ListOfBooksVC {
    func readingBook(indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenBook = listOfBooks[indexPath.row]
        if chosenBook.currentPage < chosenBook.numberOfPages  {
            chosenBook.currentPage += 30
        } else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription   )
        }
    }
    
    func removeData(indexPath : IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(listOfBooks[indexPath.row])
        do {
            try managedContext.save()
            self.listOfBooks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func loadData(completionHandler : (_ complete : Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchContext = NSFetchRequest<Book>(entityName: "Book")
        
        do {
            listOfBooks = try managedContext.fetch(fetchContext)
            completionHandler(true)
        } catch {
            debugPrint(error.localizedDescription)
            completionHandler(false)
        }
    }
}
