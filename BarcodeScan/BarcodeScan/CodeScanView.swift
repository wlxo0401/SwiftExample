//
//  CodeScanView.swift
//  BarcodeScan
//
//  Created by 김지태 on 2023/01/06.
//

import UIKit
import AVFoundation

//MARK: - 상태 값
enum ReaderStatus {
    case success(_ code: String?)
    case fail
    case stop
}

//MARK: - 상태 전송 Delegate
protocol CodeReaderViewDelegate: AnyObject {
    func readerComplete(status: ReaderStatus)
}

//MARK: - QR, BarCode... 읽는 Custom View
class CodeReaderView: UIView {

    // 동작 Delegate
    weak var delegate: CodeReaderViewDelegate?
    // 화면이 그려질 Layer
    var previewLayer: AVCaptureVideoPreviewLayer?
    // iOS와 macOS 환겨에서 모든 미디어 캡쳐를 위한 클래스이다. 이 객체는 입력 데이터에서 미디어 출력 까지의 과정과 캡쳐 작업을 모두 관리한다.
    var captureSession: AVCaptureSession?
    // 캡처 장치는 AVCapture 세션에 연결하는 세션 입력을 캡처하기 위한 미디어 데이터를 제공한다. 개별 장치는 특정 유형의 미디어 스트림을 하나 이상 제공할 수 있다.
    var captureDevice: AVCaptureDevice?
    
    // Reader 기능이 실행중인지 확인
    var isRunning: Bool {
        guard let captureSession = self.captureSession else {
            return false
        }
        return captureSession.isRunning
    }

    // 인식하고 싶은 Code 종류
    let metadataObjectTypes: [AVMetadataObject.ObjectType] = [
                                                              .upce,
                                                              .code39,
                                                              .code39Mod43,
                                                              .code93,
                                                              .code128,
                                                              .ean8,
                                                              .ean13,
                                                              .aztec,
                                                              .pdf417,
                                                              .itf14,
                                                              .dataMatrix,
                                                              .interleaved2of5,
                                                              .qr
                                                             ]

    // init 실행
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetupView()
    }
    

    private func initialSetupView() {
        self.clipsToBounds = true
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
//        self.captureDevice = videoCaptureDevice

        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        guard let captureSession = self.captureSession else {
            self.fail()
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            self.fail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = self.metadataObjectTypes
        } else {
            self.fail()
            return
        }
        
        self.setPreviewLayer()
    }

    func setPreviewLayer() {
        guard let captureSession = self.captureSession else {
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        previewLayer.frame = UIScreen.main.bounds
        previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.frame.height)
        
        self.layer.addSublayer(previewLayer)

        self.previewLayer = previewLayer
    }
}

extension CodeReaderView {
    func start() {
        self.captureSession?.startRunning()
    }
    
    func stop() {
        self.captureSession?.stopRunning()
        
        self.delegate?.readerComplete(status: .stop)
    }
    
    func fail() {
        self.delegate?.readerComplete(status: .fail)
        self.captureSession = nil
    }
    
    func found(code: String) {
        self.delegate?.readerComplete(status: .success(code))
    }
}

extension CodeReaderView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        stop()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let stringValue = readableObject.stringValue else {
                return
            }

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
}
