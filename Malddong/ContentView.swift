//
//  ContentView.swift
//  Malddong
//
//  Created by 이종원 on 12/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var network = ToiletAPI.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.toiletItem, id: \.self) { result in
                    HStack {
                        AsyncImage(url: URL(string: result.photo?.first ?? "")) { image in
                            image.image?.resizable()
                        }
                        .frame(width: 120, height: 80)
                        Text(result.toiletNm)
                            .bold()
                    }
                    .padding(5)
                }
            }.navigationTitle("제주도 화장실")
        }
        .onAppear() {
            network.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
