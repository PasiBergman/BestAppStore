//
//  AppFullScreenController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    var handleCloseViewClick: (() -> ())?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.layer.cornerRadius = todayCellCornerRadius
        
        let statusBarHeight = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: statusBarHeight.height, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let firstRowCell = AppFullScreenHeaderCell()
            firstRowCell.todayCell.todayItem = todayItem
            firstRowCell.didClickCloseButton = handleCloseViewClick
            return firstRowCell
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
            return todayCellHeight
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

}
