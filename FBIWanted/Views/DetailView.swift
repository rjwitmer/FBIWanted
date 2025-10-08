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
    @State private var dobIndex: Int = 0
    @State private var selectAlias: Int = 0
    @State private var selectDOB: Int = 0
    
    var body: some View {
        
        List {
            Text(person.title.capitalized)
                .font(.title)
                .fontWeight(.bold)
            
//            Rectangle()     // Create a separator line
//                .frame(height: 1)
//                .foregroundStyle(Color.white)
//                .padding(.bottom)
            
            HStack {
                personImage
                
                VStack(alignment: .leading) {
                    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 1) {
                        GridRow {
                            Text("Subjects: ")
                                .foregroundStyle(Color.indigo)
                            
                            Text(person.subjects.joined(separator: ", "))
                        }
                        GridRow {
                            Text("Description:")
                                .foregroundStyle(Color.indigo)
                            
                            Text(person.description)
                        }
                        
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
                    .foregroundStyle(Color.indigo)
                Text(person.description)
                    .font(.title2)
                Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 1) {
                    GridRow {
                        Text("Aliases:")
                            .foregroundStyle(Color.indigo)
                        if person.aliases == nil {
                            Text("unidentified")
                        } else {
                            if person.aliases!.count > 1 {
                                Picker(selection: $selectAlias, label: Text("Alias:")) {
                                    ForEach(0..<person.aliases!.count, id: \.self) {
                                        Text("\(person.aliases![$0])")
                                    }
                                }
                            } else {
                                Text(person.aliases!.first ?? "")
                            }
                        }
                    }
                    GridRow {
                        Text("Date(s) of Birth:")
                            .foregroundStyle(Color.indigo)
                        if person.dates_of_birth_used == nil {
                            Text("unidentified")
                        } else {
                            if person.dates_of_birth_used!.count > 1 {
                                //                            Stepper("\(person.dates_of_birth_used![dobIndex])", value: $dobIndex, in: 0...person.dates_of_birth_used!.count-1)
                                Picker(selection: $selectDOB, label: Text("DOB:")) {
                                    ForEach(0..<person.dates_of_birth_used!.count, id: \.self) {
                                        Text("\(person.dates_of_birth_used![$0])")
                                    }
                                }
                                
                            } else {
                                Text("\(person.dates_of_birth_used!.first ?? "unidentified")")
                            }
                        }
                    }
                    GridRow {
                        Text("Place of Birth:")
                            .foregroundStyle(Color.indigo)
                        if person.place_of_birth == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.place_of_birth!)")
                        }
                    }
                    GridRow {
                        Text("Hair:")
                            .foregroundStyle(Color.indigo)
                        if person.hair == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.hair!)")
                        }
                    }
                    GridRow {
                        Text("Eyes:")
                            .foregroundStyle(Color.indigo)
                        if person.eyes == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.eyes!)")
                        }
                    }
                    GridRow {
                        Text("Height:")
                            .foregroundStyle(Color.indigo)
//                        if person.height_min == nil && person.height_max == nil {
//                            Text("unidentified")
//                        } else if person.height_min == nil {
//                            Text("\(person.height_max!)")
//                        } else if person.height_max == nil {
//                            Text("\(person.height_min!)")
//                        } else {
//                            Text("\(person.height_min!) - \(person.height_max!)")
//                        }
                        if person.height == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.height!)")
                        }
                    }
                    GridRow {
                        Text("Weight:")
                            .foregroundStyle(Color.indigo)
                        if person.weight == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.weight!)")
                        }
                    }
                    GridRow {
                        Text("Sex:")
                            .foregroundStyle(Color.indigo)
                        if person.sex == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.sex!)")
                        }
                    }
                    GridRow {
                        Text("Race:")
                            .foregroundStyle(Color.indigo)
                        if person.race == nil {
                            Text("unidentified")
                        } else {
                            Text("\(person.race!.capitalized)")
                        }
                    }
                }
                .font(.title2)
                
                Text("Reward:")
                    .foregroundStyle(Color.indigo)
                if person.reward_text == nil {
                    Text("unidentified")
                } else {
                    Text("\(person.reward_text!)")
                }
                Text("Remarks:")
                    .foregroundStyle(Color.indigo)
                if person.remarks == nil {
                    Text("unidentified")
                } else {
                    Text("\(person.remarks!.htmlToString())")
                }
                Text("Details:")
                    .foregroundStyle(Color.indigo)
                if person.details == nil {
                    Text("unidentified")
                } else {
                    Text("\(person.details!.htmlToString())")
                }
                
                
            }
            .font(.largeTitle)
            
            Spacer()
        }
    }
}

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .utf8)!,
                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil).string
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
                    .frame(height: 225)
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
//                Text("Phase Error: \(phase.error?.localizedDescription ?? "No Error")")
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
    DetailView(person: Person(title: "Dante Witmer",
                              description: "I am a very good boy.",
                              subjects: ["Wanted English Spriger Spaniel"],
                              aliases: ["Buddy","Good Boy"],
                              images: [PersonImage(large: "https://www.dogbreedinfo.com/images25/EnglishSpringerSpanielPureBredDogBechamGroomed10MonthsOld1.jpg")],
                              dates_of_birth_used: ["September 7, 2014"],
                              place_of_birth: "Nanjay, Markham, ON, Canada",
                              hair: "Black and White",
                              eyes: "Big and Brown",
                              height: "15 in",
//                              height_min: "15 in",
//                              height_max: "16 in"
                              weight: "19.2 Kg",
                              sex: "Neutered Male",
                              race: "English Springer Spaniel",
                              reward_text: "Hugs and Kisses",
                              remarks: "Approachable and friendly"
                             )
    )
    
    
}
