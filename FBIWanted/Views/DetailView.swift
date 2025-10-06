//
//  DetailView.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import SwiftUI

struct DetailView: View {
    let person: Person
    @State private var personImageIndex: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(person.title.capitalized)
                .font(.title)
                .fontWeight(.bold)
            
            Rectangle()     // Create a separator line
                .frame(height: 1)
                .foregroundStyle(Color.white)
                .padding(.bottom)
            
            HStack {
                personImage
//                Image(systemName: "person.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .shadow(radius: 8, x: 5, y: 5)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 16)
//                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
//                    }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Subjects: ")
                            .foregroundStyle(Color.red)
                        
                        Text(person.subjects.joined(separator: ", ")) // TODO: Change to returned
                        
                    }
                    .font(.largeTitle)
                    
                }
            }
            
            VStack(alignment: .leading) {
                if person.images!.count > 1 {
                    Stepper("Image:", value: $personImageIndex, in: 0...person.images!.count-1)
                        .frame(width: 200)
                }
                Text("Description:")
                    .foregroundStyle(Color.red)
                Text(person.description)
                    .font(.title2)
                Text("Aliases:")
                    .foregroundStyle(Color.red)
                if person.aliases == nil {
                    Text("None")
                        .font(.title3)
                } else {
                    List(person.aliases!, id: \.self) { alias in
                        Text(alias)
                            .font(.title3)
                    }
                    .listStyle(.plain)
                }
                
            }
            .font(.largeTitle)
            
            Spacer()
        }
    }
}

extension DetailView {
    var personImage: some View {
        AsyncImage(url: URL(string: person.images?[personImageIndex].large ?? "")) { phase in
            if let image = phase.image {    // We have a valid image
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
                
            } else if phase.error != nil {  // We've had an error, load a empty image
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 8, x: 5, y: 5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
            } else {    // Use a placeholder - image loading

                ProgressView()
                    .tint(Color.red)
                    .scaleEffect(4.0)
            }
        }
        .frame(width: 200, height: 200)
        .padding(.trailing)
        
    }
}

#Preview {
    DetailView(person: Person(title: "Dante Witmer", description: "I am a very good boy.", subjects: ["Wanted English Spriger Spaniel"], aliases: ["Buddy"], images: [PersonImage(large: "https://www.dogbreedinfo.com/images25/EnglishSpringerSpanielPureBredDogBechamGroomed10MonthsOld1.jpg")]))

}
