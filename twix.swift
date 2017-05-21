import Foundation
import Files

// MARK: - Extensions

private extension String {
    var isComment: Bool {
        return self.hasPrefix("//")
    }
}

// MARK: - Program

let allFiles = FileSystem().currentFolder.makeFileSequence(recursive: true)
let swiftFiles = allFiles.filter({ $0.extension == "swift" })

guard !swiftFiles.isEmpty else {
    print("No Swift files found at path: \(FileSystem().currentFolder.path)")
    exit(1)
}

var filesToTwixt: [File] = []

for file in swiftFiles {
    let contents = try file.readAsString()
    let components = contents.components(separatedBy: .newlines)

    guard components.count > 6 else {
        print("Error: \(file.name) missing pattern. File must contain more than 6 lines!")
        continue
    }

    var firstSevenLines: [String] = []

    for i in 0...6 {
        firstSevenLines.append(components[i])
    }

    guard !firstSevenLines.filter({ $0.isComment }).isEmpty else {
        print("Error: \(file.name) missing pattern. First 7 lines must start with '//'!")
        continue
    }

    let line0 = firstSevenLines[0]
    let line1 = firstSevenLines[1]
    let line2 = firstSevenLines[2]
    let line3 = firstSevenLines[3]
    let line4 = firstSevenLines[4]
    let line5 = firstSevenLines[5]
    let line6 = firstSevenLines[6]

    guard line0 == "//" else {
        print("Error: \(file.name) missing pattern. First line must equal '//'!")
        continue
    }

    guard line1.contains(".swift") else {
        print("Error: \(file.name) missing pattern. Second line must contain '.swift'!")
        continue
    }

    guard line3 == "//" else {
        print("Error: \(file.name) missing pattern. Forth line must equal '//'!")
        continue
    }

    guard line4.contains("Created by") else {
        print("Error: \(file.name) missing pattern. Fifth line must contain 'Created by'!")
        continue
    }

    guard line5.contains("Copyright") else {
        print("Error: \(file.name) missing pattern. Sixth line must contain 'Copyright'!")
        continue
    }

    guard line6 == "//" else {
        print("Error: \(file.name) missing pattern. Sixth line must equal '//'!")
        continue
    }

    filesToTwixt.append(file)
}

guard !filesToTwixt.isEmpty else {
    print("No Twixable files found!")
    exit(1)
}

for file in filesToTwixt {
    let contents = try file.readAsString()
    var components = contents.components(separatedBy: .newlines)

    print("Twixing file: \(file.name)")

    // First first 4 lines starting from the second line
    for _ in 0...3 {
        components.remove(at: 1)
    }

    let newContents = components.joined(separator: "\n")
    try file.write(string: newContents)
}

print("Done ✅")
print("Twixed \(filesToTwixt.count) Swift \(filesToTwixt.count == 1 ? "file" : "files")!")
