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

class IndexViewController: UIViewController,UIViewControllerTransitioningDelegate {

     var filterViewController : FilterViewController = FilterViewController()
//    lazy var filterViewController : CustomPresentationSecondViewController = CustomPresentationSecondViewController()

   

    var filterContainer: UIView!
    @IBOutlet weak var searchBar: TopSearchBar!
     var loading: UIActivityIndicatorView!
     var effectView: UIVisualEffectView!
    @IBAction func filter(_ sender: Any) {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = kCATransitionReveal
//        transition.subtype = kCATransitionFromTop
//        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(filterViewController, animated: true, completion: nil)


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.modalPresentationStyle = .custom
        filterViewController.transitioningDelegate = self
        filterViewController.modalPresentationStyle = .custom

        initWebView()
        loadingEffect()
    }
    //通过变量将 动画实例缓存起来，否则此实例在动画运行完之后，将会被回收，如果里面定义了方法，事件，手势等都将无效，并且不会报错
    var topAnimator = TopAnimator()
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return topAnimator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return topAnimator
    }
    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(false)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        print("viewWillAppear")
//    }
   public func loadingEffect()  {
        
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
        effectView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
//        effectView.snp.makeConstraints(snp)
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
        webView.backgroundColor = UIColor.white
        webView.alpha = 1
        self.view.addSubview(webView)
        webView.snp.makeConstraints{ (make) in
            make.top.equalTo(self.searchBar.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().offset(0)
        }
        let headers: HTTPHeaders = [
            "Sign": "4455f0b238d96b12e3c9adae866438eb"
        ]
        Alamofire.request("http://192.168.25.134:8033/bb1ddc9459253909d379/html", headers: headers).validate().responseJSON { response in
//            print(response["content"])
            switch response.result {
            case .success:
                if let content = response.data {
                    let data = JSON(data:content)
                    print(data)
                    webView.loadHTMLString(data["content"].stringValue, baseURL: nil)
                    self.hiddenLoading()
                }else {
                    
                }
            case .failure(let error):
                let status = response.response?.statusCode
                print(status)
                print(error)
            }
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
