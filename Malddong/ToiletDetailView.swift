//
//  ToiletDetailView.swift
//  Malddong
//
//  Created by 이종원 on 12/4/23.
//

import SwiftUI

struct ToiletDetailView: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 312, height: 180)
                .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
            HStack {
                Text("GS25제주한라점")
                    .font(
                        Font.custom("LINE Seed Sans KR", size: 18)
                            .weight(.bold)
                    )
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("연중무휴")
                  .font(
                    Font.custom("LINE Seed Sans KR", size: 10)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.trailing)
                  .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.69))
            }
            Text("제주특별자치도 제주시 한라대학로 63")
              .font(
                Font.custom("LINE Seed Sans KR", size: 12)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.69))
            
            Text("(제주특별자치도 제주시 노형동 756)")
              .font(Font.custom("LINE Seed Sans KR", size: 8))
              .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.69))
        }
    }
}

#Preview {
    ToiletDetailView()
}
