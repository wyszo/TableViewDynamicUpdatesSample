//
//  ViewController.swift
//  TestTLUpdates
//
//  Created by Wyszo on 24/08/2017.
//  Copyright © 2017 Wyszo. All rights reserved.
//

import UIKit
import TLIndexPathTools

class CustomModel {
    var text: String

    init(_ text: String) {
        self.text = text
    }
}

final class CustomModelTableViewController: TLTableViewController {

    let models = [
        [ CustomModel("first"), CustomModel("second"), CustomModel("third") ],
        [ CustomModel("third"), CustomModel("second"), CustomModel("first") ],
        [ CustomModel("third") ],
        [ CustomModel("first"), CustomModel("second"), CustomModel("third"), CustomModel("fourth"), CustomModel("fifth") ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        triggerModelUpdate()
    }

    func triggerModelUpdate() {
        let rand = Int(arc4random()) % models.count

        update(dataModelItems: models[rand])

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.triggerModelUpdate()
        }
    }

    func update(dataModelItems items: [CustomModel]) {
        let indexPathItems = items.map { TLIndexPathItem(identifier: $0.text, sectionName: nil, cellIdentifier: nil, data: $0) }
        indexPathController.dataModel = TLIndexPathDataModel(items: indexPathItems)
    }

    override func tableView(_ tableView: UITableView!, configureCell cell: UITableViewCell!, at indexPath: IndexPath!) {
        let item = indexPathController.dataModel?.item(at: indexPath) as! TLIndexPathItem
        let model = item.data as! CustomModel
        cell.textLabel?.text =  model.text
    }
}
