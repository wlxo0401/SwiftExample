//
//  SocketStudy.swift
//  NSStreamSocket
//
//  Created by 김지태 on 2023/02/08.
//

import Foundation

class SocketStudy: NSObject, StreamDelegate {
    static let shared = SocketStudy()
    
    private override init() { }
    
    var host:String?
    var port:Int?
    var inputStream: InputStream?
    var outputStream: OutputStream?

    // 소켓 연결
    func connect(host: String, port: Int) {
        self.host = host
        self.port = port

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


    // 데이터 전송
    func send(data: Data) -> Int {
        let bytesWritten = data.withUnsafeBytes {
            outputStream?.write($0, maxLength: data.count)
        }
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

    // 연결 해제
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
