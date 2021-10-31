//
//  BookCell.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 14.10.2021.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var lblNameOfBook: UILabel!
    @IBOutlet weak var lblReadingPeriod: UILabel!
    @IBOutlet weak var lblCurrentPage: UILabel!
    @IBOutlet weak var completedView: UIView!
    
    func setViewCell(book : Book) {
        lblNameOfBook.text = book.nameOfBook
        lblReadingPeriod.text = book.readingPeriod
        lblCurrentPage.text = String(book.currentPage)
        
        if book.currentPage >= book.numberOfPages {
            completedView.isHidden = false
        } else {
            completedView.isHidden = true
        }
    }
    
}
