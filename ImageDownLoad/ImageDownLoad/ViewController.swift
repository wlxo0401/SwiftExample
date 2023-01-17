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
    
    let Authorization: String = "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDA4OTQwNzAsInVzZXJfbmFtZSI6IjpvYXV0aDpAUklERVJAMzg0N0A1MDEyNyIsImF1dGhvcml0aWVzIjpbIlJPTEVfQVBQIl0sImp0aSI6IjU1MTVjMTk0LWY1M2MtNDA2OS04ZjI5LTRhMjAwOTNmYWUxZCIsImNsaWVudF9pZCI6ImFsb2EtYXBwIiwic2NvcGUiOlsicmVhZCIsIndyaXRlIl19.T1ItGxmmFg3YK7ktzYQY85uVktVmTH4ccIQpc0jYsBmNZJIvZqe40EHE9zHln-vsErYaewr40zX7oD2QcjQO-yH7_mzIewxMVHH8clEjxxEAPaZ1M0euWz76HKxlD7zUxhiS561Dmkou2GjD8w61tF55Irjm6H_bTYeVThddgdMwVUnz9uwcsIk2bGG8sXdeqg4FIvb0TJAAmCzpvJay9g3nqb1sW8XQnEJqoGUZMvmtqeTv6qkRG3Qr8bVVuSKWY1LpD8kQmjO_WsLBX_Vvjzh_KK9qXibWgk0yOVDKIc362p148dWNqcAatrIl5MDRFHJTZ2Q2thVwVwdYOE72yQ"
    let url: String = "https://aloa-dev.logisteq.com:7171/api/riders/3847/profile-image"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 2022/10/26 - 김지태 라이브러리/EnResource 폴더 Path 얻기
    internal func getEnResourcePath() -> String {
        
        // 1. 라이브러리 폴더 URL 메소드로 받기
        let libraryURL = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        
        // 2. libraryURL에 하위 path 붙이기
        let directoryURL = (libraryURL as NSString).appendingPathComponent("EnResource")
    
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
        request.addValue(self.Authorization, forHTTPHeaderField: "Authorization")

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
        request.addValue(self.Authorization, forHTTPHeaderField: "Authorization")
        
         
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
        
        let header: HTTPHeaders = [
                    "Accept":"*/*",
                    "Authorization" : self.Authorization
                ]
        
        AF.request(self.url, method: .get, headers: header)
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

