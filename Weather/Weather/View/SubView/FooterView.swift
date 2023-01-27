//
//  FooterView.swift
//  myWeather
//
//  
//

import SwiftUI

struct FooterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button {
                withAnimation(.easeIn) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image(systemName: "plus.square")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
