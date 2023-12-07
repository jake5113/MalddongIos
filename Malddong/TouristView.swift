//
//  TouristView.swift
//  Malddong
//
//  Created by 이종원 on 12/4/23.
//

import SwiftUI

struct TouristView: View {
    
    @StateObject var network = TouristAPI.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.touristItem, id: \.self) { result in
                    HStack {
                        AsyncImage(url: URL(string: result.thumbnailPath )) { image in
                            image.image?.resizable()
                        }
                        .frame(width: 120, height: 80)
                        Text(result.title)
                            .bold()
                    }
                    .padding(5)
                }
            }.navigationTitle("제주도 관광지")
        }
        .onAppear() {
            network.fetchData()
        }
    }
}

#Preview {
    TouristView()
}
