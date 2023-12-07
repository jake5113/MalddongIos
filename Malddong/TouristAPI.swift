//
//  TouristAPI.swift
//  Malddong
//
//  Created by 이종원 on 12/4/23.
//

import Foundation


//struct TouristResponse: Decodable {
//    let result: String
//    let info_cnt: Int
//    let info: [TouristSpotItem]
//}
//
//struct TouristSpotItem: Decodable, Hashable {
//    let title: String // 이름
//    let introduction: String // 소개
//    let img_path: String // 일반 이미지
//    
//    let address: String // 주소
//    let latitude: String // 위도
//    let longitude: String // 경도
//    let phone_no: String // 전화번호
//    let post_code: String // 우편번호
//    let road_address: String // 도로명 주소
//    let tag: String //태그
//    let thumbnail_path: String // 썸네일 이미지
//}

struct TouristResult: Codable {
    let result: String
    let infoCnt: Int
    let info: [Info]

    enum CodingKeys: String, CodingKey {
        case result
        case infoCnt = "info_cnt"
        case info
    }
}

struct Info: Codable, Hashable {
    let contentsID: String
    let contentsLabel: String
    let title, address, roadAddress, tag: String
    let introduction: String
    let latitude, longitude: Double
    let postCode, phoneNo: String
    let imgPath, thumbnailPath: String

    enum CodingKeys: String, CodingKey {
        case contentsID = "contents_id"
        case contentsLabel = "contents_label"
        case title, address
        case roadAddress = "road_address"
        case tag, introduction, latitude, longitude
        case postCode = "post_code"
        case phoneNo = "phone_no"
        case imgPath = "img_path"
        case thumbnailPath = "thumbnail_path"
    }
}

class TouristAPI: ObservableObject {
    static let shared = TouristAPI()
    private init() { }
    
    @Published var touristItem = [Info]()
    
    private var touristApiKey: String? {
        get { getValueOfPlistFile("ApiKeys", "TOURIST_API_KEY") }
    }
    
    func fetchData() {
        guard let touristApiKey = touristApiKey else { return }
        
        let urlString = "http://api.jejuits.go.kr/api/infoTourList?code=\(touristApiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error : " + error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            do {
                let results = try JSONDecoder().decode(TouristResult.self, from: data)
                DispatchQueue.main.async {
                    self.touristItem = results.info
                }
            } catch let error {
                print("여기 : " + error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
