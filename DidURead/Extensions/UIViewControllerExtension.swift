//
//  UIViewControllerExtension.swift
//  DidURead
//
//  Created by Ahmet Engin Gökçe on 17.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func newPresent(_ viewControllerToPresent : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: "presentAnimation")
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func newSecondPresenet(_ viewControllerToPresent : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromRight
        guard let presentedVC = presentedViewController else { return }
        presentedVC.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: "secondPresentAnimation")
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func newDismiss() {
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: "dismissAnimation")
        dismiss(animated: false, completion: nil)
    }
    
}
