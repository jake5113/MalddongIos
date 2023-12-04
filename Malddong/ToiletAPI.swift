//
//  ToiletAPI.swift
//  Malddong
//
//  Created by 이종원 on 12/1/23.
//

import Foundation

struct ToiletResponse : Decodable {
    let response: Response
}

struct Response: Decodable {
    let body: Body
    let header: Header
}

struct Header: Decodable {
    let resultCode: String
    let resultMsg: String
}

struct Body: Decodable {
    let items: Items
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct Items: Decodable {
    let item: [ToiletItem]
}

struct ToiletItem: Decodable, Hashable {
    let toiletNm: String // 화장실 명
    let lnmAdres: String // 지번주소
    let photo: [String]? // 사진
    
    let laCrdnt: String  // 위도
    let loCrdnt: String  // 경도
    let emdNm: String  //읍면동명
    let rnAdres: String  // 도로명주소
    
    let opnTimeInfo: String // 개방 시간 정보
    let mngrInsttNm: String // 관리 기관 명
    let toiletPosesnSeNm: String  // 화장실 소유 구분 명
    let telno: String // 전화번호
    let photoYn: String  // 사진 유무
    
    let mwmnCmnuseToiletYn: String  // 남녀공용화장실여부
    let diaperExhgTablYn: String  // 기저귀교환탁자여부
    let etcCn: String // 기타 내용
    
    let maleClosetCnt: String // 남성 대변기 수
    let maleUrinalCnt: String // 남성 소변기 수
    let maleDspsnClosetCnt: String // 남성 장애인 대변기 수
    let maleDspsnUrinalCnt: String // 남성 장애인 소변기 수
    let maleChildClosetCnt: String // 남성 어린이 대변기 수
    let maleChildUrinalCnt: String // 남성 어린이 소변기 수
    
    let femaleClosetCnt: String // 여성 대변기 수
    let femaleChildClosetCnt: String  // 여성 장애인 대변기 수
    let femaleDspsnClosetCnt: String  // 여성 어린이 대변기 수
}

class ToiletAPI: ObservableObject {
    static let shared = ToiletAPI()
    private init() { }
    
    @Published var toiletItem = [ToiletItem]()
    
    private var toiletApiKey: String? {
        get { getValueOfPlistFile("ApiKeys", "TOILET_API_KEY") }
    }
    
    func fetchData() {
        guard let toiletApiKey = toiletApiKey else { return }
        
        let urlString = "https://apis.data.go.kr/6510000/publicToiletService/getPublicToiletInfoList?pageNo=1&numOfRows=500&serviceKey=\(toiletApiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ToiletResponse.self, from: data)
                DispatchQueue.main.async {
                    self.toiletItem = results.response.body.items.item
//                    print(self.toiletItem)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
