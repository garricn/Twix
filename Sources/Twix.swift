//
//  Twix.swift
//  Twix
//
//  Created by Garric G. Nahapetian on 5/20/17.
//
//

import Foundation
import Files

// MARK: - Twix.swift

// MARK: Extensions

private extension String {
    var isComment: Bool {
        return self.hasPrefix("//")
    }
}

// MARK: - Functions

extension File {

    var isSwiftFile: Bool {
        return self.extension == "swift"
    }

    var isTwixable: Bool {
        let file = self

        guard let contents = try? file.readAsString() else {
            print("Error: could not read contents of file: \(file.name)")
            return false
        }

        let components = contents.components(separatedBy: .newlines)

        guard components.count > 6 else {
            print("Error: \(file.name) missing pattern. File must contain more than 6 lines!")
            return false
        }

        var firstSevenLines: [String] = []

        for i in 0...6 {
            firstSevenLines.append(components[i])
        }

        guard !firstSevenLines.filter({ $0.isComment }).isEmpty else {
            print("Error: \(file.name) missing pattern. First 7 lines must start with '//'!")
            return false
        }

        let line0 = firstSevenLines[0]
        let line1 = firstSevenLines[1]
        let line3 = firstSevenLines[3]
        let line4 = firstSevenLines[4]
        let line5 = firstSevenLines[5]
        let line6 = firstSevenLines[6]

        guard line0 == "//" else {
            print("Error: \(file.name) missing pattern. First line must equal '//'!")
            return false
        }

        guard line1.contains(".swift") else {
            print("Error: \(file.name) missing pattern. Second line must contain '.swift'!")
            return false
        }

        guard line3 == "//" else {
            print("Error: \(file.name) missing pattern. Forth line must equal '//'!")
            return false
        }

        guard line4.contains("Created by") else {
            print("Error: \(file.name) missing pattern. Fifth line must contain 'Created by'!")
            return false
        }

        guard line5.contains("Copyright") else {
            print("Error: \(file.name) missing pattern. Sixth line must contain 'Copyright'!")
            return false
        }

        guard line6 == "//" else {
            print("Error: \(file.name) missing pattern. Sixth line must equal '//'!")
            return false
        }

        return true
    }

    func twix() {
        let file = self

        guard let contents = try? file.readAsString() else {
            print("Error: could not read contents of file: \(file.name)")
            return
        }

        var components = contents.components(separatedBy: .newlines)

        print("Twixing file: \(file.name)")

        // First first 4 lines starting from the second line
        for _ in 0...3 {
            components.remove(at: 1)
        }

        let newContents = components.joined(separator: "\n")
        do {
            try file.write(string: newContents)
        } catch {
            print("Error writing contents to file: \(error)")
        }
    }
}
