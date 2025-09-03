//
//  DetailView.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import SwiftUI

struct DetailView: View {
    let person: Person
    
    var body: some View {
        VStack {
            Text(person.title.capitalized)
                .font(Font.custom("AvenidaNext-Bold", fixedSize: 60))
            
            Rectangle()     // Create a separator line
                .frame(height: 1)
                .foregroundStyle(Color.white)
                .padding(.bottom)
            
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Sex: ")
                            .foregroundStyle(Color.red)
                        
                        Text(person.sex.capitalized)

                    }
                    .font(.largeTitle)

                }
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Description:")
                        .foregroundStyle(Color.red)
                    Text("Witmer")
                }
            }
            .font(.largeTitle)
            
            Spacer()
        }
    }
}

#Preview {
    DetailView(person: Person(title: "Dante Witmer"))
}
