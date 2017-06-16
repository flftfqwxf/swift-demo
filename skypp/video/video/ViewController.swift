//
//  ViewController.swift
//  video
//
//  Created by leixianhua on 5/15/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let listId = "list"
    var refreshControl: UIRefreshControl?

    var datas = [
            [
                    1, 2, 3, 4
            ],
            [11, 22, 33]

    ]
    var count = 0
    var list = UITableView(frame: UIScreen.main.bounds, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()

//        Alamofire.request("http://127.0.0.1:8033/8a15fbb94471050bb46f/list").response { response in
//            // method defaults to `.get`
////            debugPrint(response)
//            do {
//                let data = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                print(response)
//
//            } catch {
//            }
//
//        }
        list.register(UITableViewCell.self, forCellReuseIdentifier: listId)
        list.dataSource = self
        list.delegate = self
        list.backgroundColor = UIColor(red: 0, green: 152.0, blue: 204.0, alpha: 1)
        list.separatorInset = UIEdgeInsetsMake(0, 10, 0, 50)
        list.separatorColor = UIColor.red
        list.separatorEffect = UIVisualEffect()
        list.sectionHeaderHeight = 150
        list.setEditing(true, animated: true)
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(onPullToFresh), for: UIControlEvents.valueChanged)
        refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        list.addSubview(refreshControl!)
        view.addSubview(list)
//        onPullToFresh()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func onPullToFresh() {
        refreshControl!.attributedTitle = NSAttributedString(string: "松开刷新")
        Alamofire.request("http://127.0.0.1:8033/8a15fbb94471050bb46f/list").responseJSON { response in
            debugPrint(response)

            if let json = response.data {
                var data = JSON(data: json)
//                print(data["list"])

//                let t = data["list"].arrayValue
//                var t: [JSON] = data["list"].arrayValue
//                print(t)
                if var list = data["list"].arrayObject {
//                    print(list)
                    let c_data = list as! [Array<Int>]
                    self.datas += c_data
//                    self.datas.insert(<#T##newElement: [Int]##[Swift.Int]#>, at: <#T##Int##Swift.Int#>)
                } else {
                    print("error:\(data["list"])")
                }
                self.list.reloadData()
                self.refreshControl!.endRefreshing()
            }
        }

//        Alamofire.request("http://127.0.0.1:8033/8a15fbb94471050bb46f/list").response { response in
//            // method defaults to `.get`
////            debugPrint(response)
//            do {
//                let data = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
//                datas=(data as AnyObject).list!
//                print(response)
//                self.list.reloadData()
//
//                self.refreshControl!.endRefreshing()
//
//            } catch {
//            }
//
//        }
//        var temp = [Int]()
//        for _ in 0..<5 {
//            temp.append(Int(arc4random() % 1000))
//        }
//        datas.insert(temp, at: 0)


    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listId, for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: listId)
//        print(indexPath)
        cell.textLabel!.text = String(datas[indexPath.section][indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datas[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        } else if editingStyle == .insert {
            datas[indexPath.section].insert(77, at: indexPath.row + 1)
            let zyIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)

            tableView.insertRows(at: [zyIndexPath], with: UITableViewRowAnimation.middle)
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " this is header"
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "this is footer"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("this is click event \(datas[indexPath.section][indexPath.row])")
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {

        if indexPath.row % 2 == 0 {
            return UITableViewCellEditingStyle.insert

        } else {
            return UITableViewCellEditingStyle.delete
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

