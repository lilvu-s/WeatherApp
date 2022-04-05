//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Ангеліна Семенченко on 25.03.2022.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
    private var pages = [UIViewController]()
    private let pageControl = UIPageControl()
    private let initialPage = 0
    private let firstPage = MainViewController()
    private let secondPage = SecondViewController()
    private let thirdPage = ThirdViewController()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: false)
        setupConstraints()
    }
    
    private func setupConstraints() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let controllers = pageViewController.viewControllers else { return }
        let pageContentViewController = controllers[0]
        pageControl.currentPage = pages.firstIndex(of: pageContentViewController) ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController) {
            if index == 0 {
                return pages.last
            } else {
                return pages[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController) {
            if index < pages.count - 1 {
                return pages[index + 1]
            } else {
                return pages.first
            }
        }
        return nil
    }
}
