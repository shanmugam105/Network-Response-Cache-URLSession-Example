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
    
    func border(color: UIColor = .clear, width: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 4, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
}

extension UIStackView {
    func clearItems() {
        self.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}

public class AlertBoxAction {
    public typealias Action = () -> Void
    
    let title: String
    let action: Action
    let fill: Bool
    
    public init(title: String, fill: Bool = true, action: @escaping AlertBoxAction.Action) {
        self.title = title
        self.action = action
        self.fill = fill
    }
    
    @objc func selector() {
        action()
    }
}

public class AlertBoxController: UIViewController {
    public static var themeColor: UIColor = .systemBlue
    @IBOutlet private weak var actionStackView: UIStackView!
    @IBOutlet private weak var baseContainerView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    private var alertTitle: String!
    private var alertDescription: String!
    private lazy var actions: [AlertBoxAction] = [.init(title: "Dismiss", fill: false) { self.dismiss(animated: true) }]
    
    public init(title: String, description: String, actions: AlertBoxAction...) {
        self.alertTitle = title
        self.alertDescription = description
        super.init(
            nibName: String(describing: AlertBoxController.self),
            bundle: Bundle(for: AlertBoxController.self)
        )
        if !actions.isEmpty {
            self.actions = actions
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVisualEffect()
        setupAlertContainer()
    }
    
    private func setupAlertContainer() {
        titleLabel.text = self.alertTitle
        descriptionLabel.text = self.alertDescription
        baseContainerView.cornerRadius()
        actionStackView.clearItems()
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 8.0
        actions.forEach { action in
            let btn = actionButton(action: action, color: AlertBoxController.themeColor, fill: action.fill)
            actionStackView.addArrangedSubview(btn)
        }
        baseContainerView.dropShadow(color: .black, opacity: 0.2)
    }
    
    private func setupVisualEffect() {
        let blur: UIBlurEffect = .init(style: .light)
        visualEffectView.effect = blur
    }
    
    private func actionButton(action: AlertBoxAction, color: UIColor, fill: Bool = true) -> UIView {
        let btn: UIButton = .init()
        let action = action
        btn.addTarget(action, action: #selector(action.selector), for: .touchUpInside)
        btn.setTitle(action.title, for: .normal)
        btn.setTitleColor(fill ? .white : color, for: .normal)
        btn.backgroundColor = fill ? color : .white
        btn.border(color: fill ? .clear : color, width: 0.5)
        btn.cornerRadius()
        btn.dropShadow(color: color, opacity: 0.7)
        let containerView: UIView = .init()
        containerView.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            btn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            btn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            btn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4)
        ])
        return containerView
    }
}
