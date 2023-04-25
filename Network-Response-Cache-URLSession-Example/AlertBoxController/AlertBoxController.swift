//
//  AlertBoxController.swift
//  Network-Response-Cache-URLSession-Example
//
//  Created by Sparkout on 21/04/23.
//

import UIKit

extension UIView {
    func cornerRadius(with radius: CGFloat = 8.0) {
        self.layer.cornerRadius = radius
    }
}

extension UIStackView {
    func clearItems() {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}

struct AlertBoxAction {
    
}

class AlertBoxController: UIViewController {
    
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var baseContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    private var alertTitle: String?
    private var alertDescription: String?
    
    init(title: String? = nil, description: String? = nil) {
        self.alertTitle = title
        self.alertDescription = description
        super.init(
            nibName: String(describing: AlertBoxController.self),
            bundle: Bundle(for: AlertBoxController.self)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseContainerView.cornerRadius()
        actionStackView.clearItems()
    }
}
