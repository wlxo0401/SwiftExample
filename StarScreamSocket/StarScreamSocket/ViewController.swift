//
//  ViewController.swift
//  StarScreamSocket
//
//  Created by 김지태 on 2023/02/08.
//

import UIKit

// 웹 소켓
import Starscream

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var informationLabelText: UILabel!
    
    private var socket: WebSocket?
    
    // 5
    deinit {
      socket?.disconnect()
      socket?.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupWebSocket()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      self.view.endEditing(true)
    }


    // viewDidLoad에서 호출
    private func setupWebSocket() {
        let url = URL(string: "ws://192.168.50.30:8282")!
        print("url :", url)
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if let message = textField.text {
            self.sendMessage(message)
        }
    }
    
    private func sendMessage(_ message: String) {
        self.title = "메세지 전송"
        socket?.write(string: message)
    }
    
    private func receivedMessage(_ message: String, senderName: String) {
        self.title = "메세지 from (\(senderName))"
        self.informationLabelText.text = message
    }
}

extension ViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            client.write(string: "kimjitae")
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            // 4-2
            guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDict = jsonData as? NSDictionary,
            let messageType = jsonDict["type"] as? String else {
                return
            }

            if messageType == "message",
            let messageData = jsonDict["data"] as? NSDictionary,
            let messageAuthor = messageData["author"] as? String,
            let messageText = messageData["text"] as? String {
                self.receivedMessage(messageText, senderName: messageAuthor)
            }
            print("received text: \(text)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("websocket is canclled")
        case .error(let error):
            print("websocket is error = \(error!)")
        }
    }
}
