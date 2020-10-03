//
//  AdditionallyView.swift
//  Rate
//
//  Created by Rotach Roman on 01.07.2020.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class WorkWithTable {
    
    func view(view: UIView, table: UITableView, button: UIButton){
        
        button.setImage(UIImage(systemName: "chevron.down.square"), for: .normal)
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 4
        table.layer.cornerRadius = 4
        
        button.layer.cornerRadius = 4
    }
    
    func hiddenTable (view: UIView, table: UITableView, button: UIButton){
        
        if view.isHidden {
            
            button.setImage(UIImage(systemName: "chevron.up.square"), for: .normal)
            view.isHidden = false
            table.isHidden = false
        } else {
            button.setImage(UIImage(systemName: "chevron.down.square"), for: .normal)
            view.isHidden = true
            table.isHidden = true
        }
    }
    
    func trueHidden (view: UIView, table: UITableView){
        view.isHidden = true
        table.isHidden = true
    }
}
