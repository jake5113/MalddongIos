//
//  ParkingAPI.swift
//  Malddong
//
//  Created by 이종원 on 12/4/23.
//

import Foundation

class ParkingAPI: ObservableObject {
    static let shared = ParkingAPI()
    private init() { }
    
//    @Published var toiletItem = [ToiletItem]()
    
    private var parkingApiKey: String? {
        get { getValueOfPlistFile("ApiKeys", "PARKING_API_KEY") }
    }
    
    func fetchData() {
        guard let parkingApiKey = parkingApiKey else { return }
        
        let urlString = "https://api.odcloud.kr/api/15050093/v1/uddi:d19c8e21-4445-43fe-b2a6-865dff832e08?page=1&perPage=600&cond%5B%EC%A7%80%EC%97%AD%EC%BD%94%EB%93%9C%3A%3AEQ%5D=50110&serviceKey=\(parkingApiKey)"
        
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
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
//            do {
//                let results = try JSONDecoder().decode(ToiletResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.toiletItem = results.response.body.items.item
////                    print(self.toiletItem)
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
            
        }
        task.resume()
    }
}
