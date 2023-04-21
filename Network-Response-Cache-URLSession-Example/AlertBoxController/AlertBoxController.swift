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

struct AlertBoxAction {
    
}

class AlertBoxController: UIViewController {
    
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var baseContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    init() {
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
        
    }
}
