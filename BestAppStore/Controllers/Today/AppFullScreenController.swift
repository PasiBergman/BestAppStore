//
//  AppFullScreenController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    internal let initialFrame: CGRect
    internal let fullScreenFrame: CGRect
    internal let todayTabBarController: UITabBarController?
    
    init(frame: CGRect, endFrame: CGRect, tabBarController: UITabBarController?) {
        self.initialFrame = frame
        self.todayTabBarController = tabBarController
        self.fullScreenFrame = endFrame
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.layer.cornerRadius = todayCellCornerRadius
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFullViewTap)))
        
        annimateViewFromCellToFullScreen()
    }
    
    fileprivate func annimateViewFromCellToFullScreen() {
        self.view.frame = initialFrame
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.view.frame = self.fullScreenFrame
            self.view.layer.cornerRadius = 0

            self.todayTabBarController?.tabBar.frame.origin.y = self.fullScreenFrame.size.height

        }, completion: nil)
    }
    
    @objc func handleFullViewTap(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.view.frame = self.initialFrame
            self.view.layer.cornerRadius = todayCellCornerRadius
            let fullHeight = self.fullScreenFrame.size.height
            if let tabBarFrame = self.todayTabBarController?.tabBar.frame {
                self.todayTabBarController?.tabBar.frame.origin.y = fullHeight - tabBarFrame.height
            }
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.translatesAutoresizingMaskIntoConstraints = false
            todayCell.widthAnchor.constraint(equalToConstant: 250).isActive = true
            todayCell.heightAnchor.constraint(equalToConstant: 250).isActive = true
            todayCell.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            todayCell.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            return cell
        }
        
        let cell = AppFullScreenDescriptionCell(style: .default, reuseIdentifier: appFullScreenDescripitionCellId)
        
        cell.descriptionTexts = [
            "Lorem ipsum dolor", " sit amet, consectetur adipiscing elit. Aliquam id risus enim. Quisque sed pharetra dui. Pellentesque aliquet dui mattis magna commodo, vel volutpat nunc pulvinar. Quisque tempus congue enim, sed maximus ligula ornare ut. Vestibulum sed volutpat arcu, ut fringilla nisi. In vehicula nisl quis mattis ultricies. Nullam venenatis sit amet tellus ac iaculis. Etiam dictum orci vel est elementum volutpat. Nam vehicula vestibulum urna sed venenatis. Donec sollicitudin metus a ex semper ullamcorper.",

            "Praesent tempor rutrum.", " Maecenas blandit lorem ac diam gravida, sed congue lectus tincidunt. Donec in ipsum id est efficitur tempor quis ut erat. Nullam a nibh posuere, convallis orci vitae, molestie tellus. Ut quis augue a velit ultricies tincidunt. Vivamus ac sem diam. Vivamus bibendum auctor diam, sed auctor quam euismod varius. Mauris eget consectetur velit. Vestibulum eleifend egestas orci, venenatis ullamcorper turpis laoreet id. Curabitur quis gravida ipsum, eget tristique ante. Sed a nulla cursus, placerat est nec, suscipit sapien.",
        ]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

}
