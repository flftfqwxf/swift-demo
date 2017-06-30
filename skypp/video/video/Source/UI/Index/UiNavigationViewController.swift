//
//  IndexViewController.swift
//  video
//
//  Created by leixianhua on 6/19/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import WebKit
import Alamofire
class FilterCell: UITableViewCell {
    
    var filterItem: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.filterItem = UILabel()
        self.filterItem.textAlignment = .center
        self.filterItem.textColor = kThemeColorBlack
        self.filterItem.font = kFontSize15
//        self.filterItem.frame=
        self.contentView.addSubview(self.filterItem)
//        self.titleLable.frame=CGRect(origin: CGPoint, size: <#T##CGSize#>)
//        self.titleLable.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsets.zero)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.filterItem.textColor = selected ? kThemeColorOrange : kThemeColorBlack
    }
}

class IndexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var filterContainer: UITableView!
    var filterItems = ["item1","item2","item3"]
     var loading: UIActivityIndicatorView!
     var effectView: UIVisualEffectView!
    
    
    @IBAction func filter(_ sender: Any) {
        self.navigationController?.pushViewController(ContrainseViewController(), animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        // 创建只带标题的UIBarButtonItem
        let nextItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: #selector(nextPage));
        let preItem = UIBarButtonItem(image: I.Image.qa_input_prev, style: .plain, target: self, action: #selector(nextPage))
        self.navigationItem.leftBarButtonItem = preItem
        self.navigationItem.rightBarButtonItem = nextItem
        self.view.backgroundColor = UIColor.red

//        filterContainer.register(FilterCell.self, forCellReuseIdentifier: "filterList")
        let nib = UINib(nibName: "FilterViewCell", bundle: nil)
        filterContainer.register( nib , forCellReuseIdentifier: "filterList")
        filterContainer.delegate = self
        filterContainer.dataSource = self
        filterContainer.backgroundColor=UIColor.white
        
        filterContainer.bounces = false
        filterContainer.separatorColor = kThemeLineGray
        filterContainer.separatorInset = UIEdgeInsetsMake(0, 28, 0, 28)
        filterContainer.tableFooterView = UIView()
//        loading.startAnimating()
        initWebView()

        loadingEffect()
//        filterContainer.
        // Do any additional setup after loading the view.
    }
    func nextPage() {
        print("nextPage")
        let vc = ContrainseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func loadingEffect()  {
        
         loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        
        effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        effectView.addSubview(loading)
        loading.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        view.addSubview(effectView)
        effectView.snp.makeConstraints{(make) in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        loading.startAnimating()
        loading.hidesWhenStopped = true
    }
    func hiddenLoading()  {
        loading.stopAnimating()
        effectView.removeFromSuperview()
    }
    func initWebView()  {
        
        let webViewConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webViewConfig)
        self.view.addSubview(webView)
        webView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.filterContainer.snp.bottom)
            make.left.right.bottom.equalToSuperview().offset(0)
        }
        let headers: HTTPHeaders = [
            "Sign": "4455f0b238d96b12e3c9adae866438eb"
        ]
        Alamofire.request("http://127.0.0.1:8033/bb1ddc9459253909d379/html", headers: headers).responseJSON { response in
//            print(response["content"])
            if let content = response.data {
                let data = JSON(data:content)
                print(data)
                webView.loadHTMLString(data["content"].stringValue, baseURL: nil)
                self.hiddenLoading()
            }
            
        }
        
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "filterList", for: indexPath) as! FilterCell
//        cell.itemLabel.text = "dddd"
//        return cell
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "filterList") as? FilterV  {
//            cell.titleLable.text = "dddd"
//            return cell
//        }
//        return UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterList", for: indexPath) as? FilterViewCell
        //        let cell = tableView.dequeueReusableCell(withIdentifier: listId)
        //        print(indexPath)
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
