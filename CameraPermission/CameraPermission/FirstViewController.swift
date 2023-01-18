//
//  ViewController.swift
//  CameraPermission
//
//  Created by 김지태 on 2023/01/17.
//

import UIKit
import PhotosUI

class FirstViewController: UIViewController {
    
    @IBOutlet weak var testImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func runCameraButtonAction(_ sender: Any) {
        PhotoCameraLibraryPermissionUtils().cameraPermission(completion: { result in
            if result {
                self.userCamera()
            } else {
                self.showAlertGoToSetting()
            }
        })
        
    }
    
    @IBAction func runAlbumButtonAction(_ sender: Any) {
        PhotoCameraLibraryPermissionUtils().albumPermission(completion: { result in
            if result {
                self.useAlbum()
            } else {
                self.showAlertGoToSetting()
            }
        })
    }
    
    
    @IBAction func runReaderViewButtonAction(_ sender: Any) {
        print("스캔 화면")
        guard let secondVc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        self.navigationController?.pushViewController(secondVc, animated: true)
    }
}

extension FirstViewController {
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
            title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
            message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
            preferredStyle: .alert)
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard let settingURL = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        
        [cancelAlert, goToSettingAlert].forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true) // must be used from main thread only
        }
    }
}

extension FirstViewController {
    //MARK: 프로필 카메라/사진첩 동작
    // 프로필 사진 카메라 선택
    func userCamera() {
        DispatchQueue.main.async {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = false
            vc.cameraFlashMode = .off
            vc.delegate = self
            self.present(vc, animated: true)
        }
    }
    
    // 프로필 사진 사진첩 선택
    func useAlbum() {
        DispatchQueue.main.async {
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .any(of: [.images])
            
            let phpPicker = PHPickerViewController(configuration: config)
            phpPicker.delegate = self
            self.present(phpPicker, animated: true, completion: nil)
        }
    }
}

//MARK: - 카메라, 사진 선택
extension FirstViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    // 사진 촬영
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        
        self.testImageView.image = image
    }
    
    // 앨범에서 사진 선택
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true) // 창 닫기 수행 실시
        
        let itemProvider = results.first?.itemProvider // 선택된 결과 가져오기
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) { // nil 체크
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // load 파일
                guard let selectedImage = image as? UIImage else { return }
                
                DispatchQueue.main.async {
                    self.testImageView.image = selectedImage
                }
            }
        }
        return
    }
}


struct PhotoCameraLibraryPermissionUtils {
    internal func cameraPermission(completion: @escaping (Bool) -> Void) {
       AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
           if granted {
               print("Camera: 권한 허용")
               return completion(true)
           } else {
               print("Camera: 권한 거부")
               return completion(false)
           }
       })
    }
    
    
    internal func albumPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
                switch authorizationStatus {
                case .limited:
                    print("limited authorization granted")
                    return completion(true)
                case .authorized:
                    print("authorization granted")
                    return completion(true)
                default:
                    print("Unimplemented")
                    return completion(false)
                }
            }
        }
    }
}
