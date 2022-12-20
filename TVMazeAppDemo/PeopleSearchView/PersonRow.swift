//
//  PersonRow.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct PersonRow: View {
    let person: Person
    
    var body: some View {
        HStack {
            RemoteImage(person.imageUrl, placeholder: .person)
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 1)
                }
            
            Text(person.name)
                .font(.headline)
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PersonRow(person: .sample)
            PersonRow(person: .sample2)
        }
    }
}
