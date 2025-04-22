import Foundation

let n = Int(readLine()!)!

var arr: [String] = []
var dict: [String : Int] = [:]

for _ in 0..<n {
    let str = readLine()!
    arr.append(str)
    let strList = str.map { $0 }
    var count: Int = 0
    strList.forEach { if $0.isNumber { count += Int(String($0))! } }
    dict[str] = count
}

arr.sorted {
    if ($0.count == $1.count) {
        if (dict[$0]! == dict[$1]!) {
            return $0 < $1
        } else {
            return dict[$0]! < dict[$1]!
        }
    }
    return $0.count < $1.count
}.forEach { print($0) }

