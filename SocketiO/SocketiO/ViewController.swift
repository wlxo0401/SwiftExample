//
//  ViewController.swift
//  SocketiO
//
//  Created by 김지태 on 2023/02/08.
//

import UIKit

import SocketIO




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SocketIOManager.shared.establishConnection()
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            SocketIOManager.shared.sendMessage(message: "asdfdjsfl", nickname: "ns")
        }
    }
}


class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    var manager = SocketManager(socketURL: URL(string: "http://192.168.50.173:8282")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/test")
        
        socket.on("test") { dataArray, ack in
            print(dataArray)
        }
    }
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
   
    func sendMessage(message: String, nickname: String) {
        socket.emit("event",  ["message" : "This is a test message"])
        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
        socket.emit("msg", ["nick": nickname, "msg" : message])
        
    }
}

