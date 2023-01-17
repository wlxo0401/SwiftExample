//
//  ViewController.swift
//  ImageDownLoad
//
//  Created by 김지태 on 2023/01/13.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 2022/10/26 - 김지태 라이브러리/EnResource 폴더 Path 얻기
    internal func getEnResourcePath() -> String {
        
        // 1. 라이브러리 폴더 URL 메소드로 받기
        let libraryURL = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        
        return libraryURL
    }
    
    @IBAction func downloadButton(_ sender: Any) {
//        self.imageDownload()
//        self.afDownload()
        self.afGet()
    }
    func imageDownload() {
        var request = URLRequest(url: try! url.asURL())
        
//        var request = URLRequest(url: self.url)
        request.httpMethod = "GET"
//        request.addValue(self.Authorization, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                print("Download image fail : \(self.url)")
                    return
            }

            DispatchQueue.main.async() {[weak self] in

                self?.imageView.image = image
            }
        }.resume()
    }
    
    
    private func afDownload() {
        
        // 파일 경로 생성
        let saveFilePath = URL(fileURLWithPath: self.getEnResourcePath()).appendingPathComponent("fileName.jpeg")
        
        let destination: DownloadRequest.Destination = { _, _ in
            return (saveFilePath, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        var request = URLRequest(url: try! url.asURL())
        request.httpMethod = "GET"
//        request.addValue(self.Authorization, forHTTPHeaderField: "Authorization")
        
         
        // 다운로드 시작
        AF.download(request, to: destination).downloadProgress { (progress) in
            print("진행도 : ", Float(progress.fractionCompleted))
            
        }.responseData{ response in
            if let data = response.value {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
            
            if response.error != nil {
                print("파일 다운로드 실패")
            }else{
                print("파일 다운로드 완료")
            }
        }
    }
    
    private func afGet() {
        
        
       print("URL : ", url)
        
//        let header: HTTPHeaders = [
//                    "Accept":"*/*",
//                    "Authorization" : self.Authorization
//                ]
        
        // AF.request(self.url, method: .get, headers: header)
        AF.request(self.url, method: .get)
                    .validate(statusCode: 200..<300)
                    //200~300사이 상태만 허용
                    .validate(contentType: ["*/*"])
                    .responseData { (response) in
                        
                        if let data = response.value {
                            let image = UIImage(data: data)
                            self.imageView.image = image
                        }
                        
                        switch response.result {
                        case .success(let response):
                            print("성공")
                        case .failure(let error):
                            print("ERROR : ", error)
                        }
                    }
    }
    
}

