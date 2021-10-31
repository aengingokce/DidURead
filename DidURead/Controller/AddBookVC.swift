//
//  AddBookVC.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 17.10.2021.
//

import UIKit

class AddBookVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtViewTypeBook: UITextView!
    @IBOutlet weak var btnInASnap: UIButton!
    @IBOutlet weak var btnFastNorSlow: UIButton!
    @IBOutlet weak var btnDeepThoughts: UIButton!
    
    var readingPeriod : ReadingPeriod = .InOneBreathe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtViewTypeBook.delegate = self
        
        headerView.layer.cornerRadius = 20
        btnInASnap.layer.cornerRadius = 20
        btnFastNorSlow.layer.cornerRadius = 20
        btnDeepThoughts.layer.cornerRadius = 20
        btnNext.layer.cornerRadius = 20
        
        let gesRecHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesRecHideKeyboard)

    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btnInASnapClicked(_ sender: Any) {
        readingPeriod = .InOneBreathe
        btnInASnap.chosenButtonColor()
        btnFastNorSlow.notChosenButtonColor()
        btnDeepThoughts.notChosenButtonColor()
    }
    
    @IBAction func btnFastNorSlowClicked(_ sender: Any) {
        readingPeriod = .NeitherFastNorSlow
        btnInASnap.notChosenButtonColor()
        btnFastNorSlow.chosenButtonColor()
        btnDeepThoughts.notChosenButtonColor()
    }
    
    @IBAction func btnDeepThoughtsClicked(_ sender: Any) {
        readingPeriod = .WithDeepThoughts
        btnInASnap.notChosenButtonColor()
        btnFastNorSlow.notChosenButtonColor()
        btnDeepThoughts.chosenButtonColor()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        if txtViewTypeBook.text != "" && txtViewTypeBook.text != "Type your book" {
            guard let createBookVC = storyboard?.instantiateViewController(withIdentifier: "CreateBookVC") as? CreateBookVC else { return }
            createBookVC.collectData(name: txtViewTypeBook.text, period: readingPeriod)
            presentingViewController?.newSecondPresenet(createBookVC)
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        newDismiss()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtViewTypeBook.text == "Type your book" {
            txtViewTypeBook.text = ""
            txtViewTypeBook.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        }
    }
    
}
