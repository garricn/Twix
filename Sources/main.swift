import Foundation
import Files

// MARK: - Program

let allFiles = FileSystem().currentFolder.makeFileSequence(recursive: true)
let swiftFiles = allFiles.filter({ $0.isSwiftFile })

guard !swiftFiles.isEmpty else {
    print("No Swift files found at path: \(FileSystem().currentFolder.path)")
    exit(1)
}

let filesToTwixt = swiftFiles.filter({ $0.isTwixable })

guard !filesToTwixt.isEmpty else {
    print("No Twixable files found!")
    exit(1)
}

for file in filesToTwixt {
    file.twix()
}

print("Done ✅")
print("Twixed \(filesToTwixt.count) Swift \(filesToTwixt.count == 1 ? "file" : "files")!")
