//
//  AppDelegate.swift
//  skypp
//
//  Created by leixianhua on 4/28/17.
//  Copyright © 2017 leixianhua. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let str = "test"
        let width:Double = 80
        let join=str+String(width)
        arrayTest()
        print(str)
        NilCoalescingOperator(val:3)
        assertTest(a:3)
        
        print(width)
        print("This is log")
        print(join)
        var optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
            print(greeting)
        }
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        
        print(informalGreeting)
        print(getStr(week:"1",day: "4"))
        print(getSecond("4",d: "4"))
        print(getMuitle(score: [10,1]))
        enumExample()
        // Override point for customization after application launch.
        return true
    }
    func arrayTest() {
        var threeDoubles = Array(repeating: "1", count: 3)
        print(threeDoubles)
    }
    func NilCoalescingOperator(val:Int)   {
        let a:Int? = val
        let b=2
        
        print(a ?? b)
    }
    func getStr(week:String,day:String)->String{
        
        return "Today is \(week) week and \(day) day"
    }
    
    func getMuitle(score:[Int]) -> (max:Int,Min:Int) {
        let max=score[0]+1
        let min=score[1]-1
        return (max,min)
    }
    func getSecond(_ minute:String,d day:String)->String{
        
        return "This is \(minute) and \(day)"
    }
    func enumExample() {
        
        enum Rank:Int{
            case spring,summer,autumn,winner
        }
        print(Rank.spring)
        print(Rank.spring.rawValue)
        
        enum Rank2: Int {
            case ace = 1
            case two, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king
            func simpleDescription() -> String {
                switch self {
                case .ace:
                    return "ace"
                case .jack:
                    return "jack"
                case .queen:
                    return "queen"
                case .king:
                    return "king"
                default:
                    return String(self.rawValue)
                }
            }
        }
        let ace = Rank2.four
        print("ace:\(ace)")
        let aceRawValue = ace.rawValue
        print("rawValue:\(aceRawValue)")
        let sim=Rank2.simpleDescription(Rank2.king)
        print(sim())
        //
        if let convertedRank = Rank2(rawValue: 3) {
            let threeDescription = convertedRank.simpleDescription()
            print("threeDescription: \(threeDescription)")
        }
        enum2()
        tupe()
        optionalTest()
        optinalBind()
    }
    func enum2() {
        enum ServerResponse {
            case result(String, String)
            case failure(String)
        }
        
        let success = ServerResponse.result("6:00 am", "8:09 pm")
        let failure = ServerResponse.failure("Out of cheese.")
        switch failure {
        case let ServerResponse.result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let ServerResponse.failure(message):
            print("Failure...  \(message)")
        }
    }
    func tupe() {
        let tupe=(1,"a","c",4)
        let (a,b,_,_)=tupe
        print(a)
        print(b)
    }
    func optinalBind(){
        let possibleNumber="12d3"
        if let actualNumber = Int(possibleNumber) {
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        } else {
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }
    }
    func optionalTest()  {
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        if convertedNumber != nil {
            print("this is optional \(convertedNumber)")
            print("this is optional \(convertedNumber!)")
            
        }
        print(convertedNumber)
        var serverResponseCode: Int? = 404
        print(serverResponseCode)
    }
    func assertTest(a:Int) {
        assert(a>2,"this is a assert")
    }
    func erro(){
        
        //    do {
        //    try makeASandwich()
        //    eatASandwich()
        //    } catch SandwichError.outOfCleanDishes {
        //    washDishes()
        //    } catch SandwichError.missingIngredients(let ingredients) {
        //    buyGroceries(ingredients)
        //    }
        //    }
        func applicationWillResignActive(_ application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        }
        
        func applicationDidEnterBackground(_ application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }
        
        func applicationWillEnterForeground(_ application: UIApplication) {
            // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        }
        
        func applicationDidBecomeActive(_ application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }
        
        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
        
        
    }
}

