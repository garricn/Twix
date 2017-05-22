import Foundation
import Files

// MARK: - Program

let allFiles: FileSystemSequence<File>

if CommandLine.arguments.count > 1 {
    let path = CommandLine.arguments[1]

    if let folder = try? Folder(path: path) {
        allFiles = folder.makeFileSequence(recursive: true)
    } else if let file = try? File(path: path), let parent = file.parent {
        allFiles = parent.makeFileSequence(recursive: false)
    } else {
        print("Error: Could not create Folder or File from input: \(path)")
        exit(1)
    }
} else {
    allFiles = FileSystem().currentFolder.makeFileSequence(recursive: true)
}

//let allFiles = FileSystem().currentFolder.makeFileSequence(recursive: true)
let swiftFiles = allFiles.filter({ $0.isSwiftFile })

guard !swiftFiles.isEmpty else {
    print("No Swift files found at path: \(FileSystem().currentFolder.path)")
    exit(1)
}

let filesToTwixt = swiftFiles.filter({ $0.isTwixable })

guard !filesToTwixt.isEmpty else {
    print("No Twixable files found.")
    exit(1)
}

for file in filesToTwixt {
    file.twix()
}

print("Done ✅")
print("Twixed \(filesToTwixt.count) Swift \(filesToTwixt.count == 1 ? "file" : "files").")
