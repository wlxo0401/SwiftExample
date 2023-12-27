//
//  ReaderView.swift
//  QrCodeSnapKit
//
//  Created by 김지태 on 12/27/23.
//

import UIKit
import AVFoundation

enum ReaderStatus {
    // 코드 인식이 성공 했을 때 이벤트입니다. 인식 된 Code를 함께 전달합니다.
    case success(_ code: String?)
    // AVCaptureSession 생성이 실패했을 경우 발생하는 이벤트입니다.
    case fail
    // 코드 인식을 중지 했을 때 발생하는 이벤트입니다. isButtonTap을 통해 어떻게 중지 되었는지 확인합니다
    case stop(_ isButtonTap: Bool)
}

protocol ReaderViewDelegate: AnyObject {
    func readerComplete(status: ReaderStatus)
}

class ReaderView: UIView {

    weak var delegate: ReaderViewDelegate?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var centerGuideLineView: UIView?
    
    var captureSession: AVCaptureSession?
    
    var isRunning: Bool {
        guard let captureSession = self.captureSession else {
            return false
        }

        return captureSession.isRunning
    }
    
    var isInitScreen: Bool = false

    let metadataObjectTypes: [AVMetadataObject.ObjectType] = [.upce, .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .aztec, .pdf417, .itf14, .dataMatrix, .interleaved2of5, .qr]

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Storyboard가 있는 상태로 작업할 떄
        // self.initialSetupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Storyboard가 있는 상태로 작업할 떄
        // self.initialSetupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Storyboard가 없을 때
        // UIView의 크기가 변경될 때 실행될 코드
        // 예: 크기가 변할 때마다 무언가를 업데이트하거나 처리
        if !self.isInitScreen {
            // 한번만 동작하게 적용. 필요시 변경가능(테스트해봐야함)
            self.initialSetupView()
            self.isInitScreen = true
        }
    }
    
    
    internal func initialSetupView() {
        self.clipsToBounds = true
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
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
        self.setCenterGuideLineView()
    }

    private func setPreviewLayer() {
        guard let captureSession = self.captureSession else {
            self.fail()
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.layer.bounds
        
        print(self.layer.bounds.width)
        print(self.layer.bounds.height)

        self.layer.addSublayer(previewLayer)

        self.previewLayer = previewLayer
    }

    private func setCenterGuideLineView() {
        let centerGuideLineView = UIView()
        centerGuideLineView.translatesAutoresizingMaskIntoConstraints = false
        centerGuideLineView.backgroundColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0.2392156863, alpha: 1)
        self.addSubview(centerGuideLineView)
        self.bringSubviewToFront(centerGuideLineView)

        centerGuideLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        centerGuideLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        centerGuideLineView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        centerGuideLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        self.centerGuideLineView = centerGuideLineView
    }
}

extension ReaderView {
    func start() {
        self.captureSession?.startRunning()
    }
    
    func stop(isButtonTap: Bool) {
        self.captureSession?.stopRunning()
        
        self.delegate?.readerComplete(status: .stop(isButtonTap))
    }
    
    func fail() {
        self.delegate?.readerComplete(status: .fail)
        self.captureSession = nil
    }
    
    func found(code: String) {
        self.delegate?.readerComplete(status: .success(code))
    }
}

extension ReaderView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        stop(isButtonTap: false)
        
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

