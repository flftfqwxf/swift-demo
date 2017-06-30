//
//  FilterViewController.swift
//  video
//
//  Created by leixianhua on 2017/6/29.
//  Copyright © 2017年 leixianhua. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var filterItems = ["item1","item2","item3"]

    @IBOutlet weak var filterContainer: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        modalPresentationStyle = .currentContext
//        modalTransitionStyle = .coverVertical
//        definesPresentationContext = true
        view.backgroundColor = .red
        let nib = UINib(nibName: "FilterViewCell", bundle: nil)
//        let view = FilterViewCell().view!
//        filterContainer.register(UITableViewCell.self, forCellReuseIdentifier: "filterList")
        filterContainer.register( nib , forCellReuseIdentifier: "filterList")
        filterContainer.delegate = self
        filterContainer.dataSource = self
        filterContainer.backgroundColor = .red
        
        filterContainer.bounces = false
        filterContainer.separatorColor = kThemeLineGray
        filterContainer.separatorInset = UIEdgeInsetsMake(0, 28, 0, 28)
        filterContainer.tableFooterView = UIView()
        filterContainer.tableHeaderView = UIView()
        self.view.addSubview(filterContainer)
        self.updatePreferredContentSizeWithTraitCollection(self.traitCollection)

        // Do any additional setup after loading the view.
    }
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == .compact ? 270 : 420)
        
//        slider.maximumValue = Float(self.preferredContentSize.height)
//        slider.minimumValue = 220
//        slider.value = self.slider.maximumValue
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.updatePreferredContentSizeWithTraitCollection(newCollection)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterList", for: indexPath) as? FilterViewCell
        
        cell?.filterItem!.text = filterItems[indexPath.row]
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
