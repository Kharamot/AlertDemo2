//
//  ViewController.swift
//  AlertDemo2
//
//  Created by Kameron Haramoto on 2/21/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var MessageLabel: UILabel!
    var notifyOk = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(notifyOk)
        {
            print("true")
        }
        else{
            print("false")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func schedNofiy(_ sender: UIButton) {
        
        if(notifyOk){
            print("OK")
        }
        else{
            
        }
        
    }

    func checkIfNotificationsStillOkay() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler:
            self.handleNotificationSettings)
    }
    func handleNotificationSettings (notificationSettings: UNNotificationSettings) {
        if ((notificationSettings.alertSetting == .enabled) &&
            (notificationSettings.badgeSetting == .enabled) &&
            (notificationSettings.soundSetting == .enabled)) {
            self.notifyOk = true
        } else {
            self.notifyOk = false
        }
    }
    
    func scheduleNotification1() {
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.body = "What’s up?"
        content.userInfo["message"] = "Yo!"
        // Configure trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,
                                                        repeats: false)
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive",
                                            content: content, trigger: trigger)
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            } }
    }
    
        func handleNotification1 (_ response: UNNotificationResponse) {
            let message = response.notification.request.content.userInfo["message"] as! String
            self.MessageLabel.text = message
        }
    
}
