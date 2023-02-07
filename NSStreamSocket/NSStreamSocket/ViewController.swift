//
//  ViewController.swift
//  NSStreamSocket
//
//  Created by 김지태 on 2023/02/07.
//

import UIKit

class ViewController: UIViewController, StreamDelegate {
    
    let host: String = "192.168.50.173"
    let port: Int = 8282
    
    var inputStream: InputStream?
    var outputStream: OutputStream?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.connect()
        
        let query = "HELLO SWIFT SOCKET!"

        let dataQuery = query.data(using: String.Encoding.utf8, allowLossyConversion: true)

        let sentCount = self.send(data: dataQuery!)

        //let sentCount = socket.send(data: query)

        print("sentCount : \(sentCount)")

        

        let buffersize = 1024

        let chunk = self.recv(buffersize: buffersize)

        

        var getString : String?

        

        if(chunk.count > 0){

            getString = String(bytes: chunk, encoding: String.Encoding.utf8)!

            print("received : \(getString!)")

        }
    }

    func connect() {
        Stream.getStreamsToHost(withName:host, port : port, inputStream: &inputStream, outputStream: &outputStream)

        if inputStream != nil && outputStream != nil {
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self

            // Schedule
            inputStream!.schedule(in: .main, forMode: .default)
            outputStream!.schedule(in: .main, forMode: .default)

            print("Start open()")

            // Open!
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    func send(data: Data) -> Int {
        let bytesWritten = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
        return bytesWritten!
    }

    func recv(buffersize: Int) -> Data {

        var buffer = [UInt8](repeating :0, count : buffersize)
        let bytesRead = inputStream?.read(&buffer, maxLength: buffersize)
        var dropCount = buffersize - bytesRead!
        if dropCount < 0 {
            dropCount = 0
        }

        let chunk = buffer.dropLast(dropCount)
        return Data(chunk)
    }



    func disconnect() {
        inputStream?.close()
        outputStream?.close()
    }
       
    
    func stream(_ stream: Stream, handle eventCode: Stream.Event) {

        

        print("event:\(eventCode)")

        

        if stream === inputStream {

            switch eventCode {

            case Stream.Event.errorOccurred:

                print("inputStream:ErrorOccurred")

            case Stream.Event.openCompleted:

                print("inputStream:OpenCompleted")

            case Stream.Event.hasBytesAvailable:

                print("inputStream:HasBytesAvailable")

                

                

            default:

                break

            }

        }

        else if stream === outputStream {

            switch eventCode {

            case Stream.Event.errorOccurred:

                print("outputStream:ErrorOccurred")

            case Stream.Event.openCompleted:

                print("outputStream:OpenCompleted")

            case Stream.Event.hasSpaceAvailable:

                print("outputStream:HasSpaceAvailable")

                

                

            default:

                break

            }

        }

    }
}

