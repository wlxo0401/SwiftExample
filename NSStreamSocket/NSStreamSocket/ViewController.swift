//
//  ViewController.swift
//  NSStreamSocket
//
//  Created by 김지태 on 2023/02/07.
//

import UIKit

// http://www.digipine.com/index.php?mid=macios&document_srl=771
class ViewController: UIViewController, StreamDelegate {
    
    @IBOutlet weak var messageTableView: UITableView!
    
    let host: String = "192.168.50.173"
    let port: Int = 8282
    
    let socket = SocketStudy.shared
    
    var uuid: String = "''"
    
    var messageFromServer: [String] = []

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uuid = self.getDeviceUUID()
        // Do any additional setup after loading the view.
        
        self.socket.connect(host: host, port: port)
        // 
        self.fromServerData()
        
        self.messageTableView.dataSource = self
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        guard let name = self.nameTextField.text else { return }
        
        if name == "" { return }
        
        guard let message = self.textField.text else { return }
        if message == "" { return }
        
        let query: String = "\(self.uuid)|+|\(name)|+|\(message)"
        let dataQuery = query.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let sentCount = self.socket.send(data: dataQuery!)
        print("sentCount : \(sentCount)")
    }
    
    // 기기 ID
    func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    private func fromServerData() {
        
        DispatchQueue.global().async {
            while true {
                let buffersize = 1024
                let chunk = self.socket.recv(buffersize: buffersize)

                var getString : String?

                if(chunk.count > 0){
                    getString = String(bytes: chunk, encoding: String.Encoding.utf8)!
                    print("received : \(getString!)")
                }
            }
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageFromServer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
