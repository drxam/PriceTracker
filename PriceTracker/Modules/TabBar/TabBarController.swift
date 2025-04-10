//
//  TabBarController.swift
//  PriceTracker
//
//  Created by dread on 09.01.2025.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "wrap_color")
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "icon_color")
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "icon_color")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        let circleSize: CGFloat = 44
        let circleImage = UIImage.circleImage(color: UIColor(red: 1.0, green: 98 / 255.0, blue: 0, alpha: 1), size: CGSize(width: circleSize, height: circleSize))
        tabBar.selectionIndicatorImage = circleImage
        
        let screen1 = MainAssembly.configureModule()
        let screen2 = BasketAssembly.configureModule()
        let screen3 = PurchasesAssembly.configureModule()
        let screen4 = SettingsAssembly.configureModule()
        
        screen1.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named: "home"), tag: 0)
        screen2.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(named: "basket"), tag: 1)
        screen3.tabBarItem = UITabBarItem(title: "Purchases", image: UIImage(named: "history"), tag: 2)
        screen4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 3)
        
        self.viewControllers = [screen1, screen2, screen3, screen4]
        
        tabBar.items?.forEach { item in
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame = CGRect(
            x: (view.frame.width - 230) / 2,
            y: view.frame.height - tabBar.frame.height - 16,
            width: 230,
            height: 60
        )
        
        tabBar.layer.cornerRadius = tabBar.frame.height / 2
        tabBar.layer.masksToBounds = true
    }
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        guard (viewControllers?.firstIndex(of: viewController)) != nil else { return false }
        previousIndex = selectedIndex
        return true
    }
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        animationControllerForTransitionFrom fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let toIndex = viewControllers?.firstIndex(of: toVC) else { return nil }
        let direction: TabBarTransitionAnimator.Direction = toIndex > previousIndex ? .right : .left
        return TabBarTransitionAnimator(direction: direction)
    }
}

extension UIImage {
    static func circleImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

class TabBarTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum Direction {
        case left
        case right
    }
    
    let duration: TimeInterval = 0.3
    let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        let offset = direction == .right ? containerView.frame.width : -containerView.frame.width
        
        toView.transform = CGAffineTransform(translationX: offset, y: 0)
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: duration,
            animations: {
                fromView.transform = CGAffineTransform(translationX: -offset, y: 0)
                toView.transform = .identity
            },
            completion: { finished in
                fromView.transform = .identity
                transitionContext.completeTransition(finished)
            }
        )
    }
}
