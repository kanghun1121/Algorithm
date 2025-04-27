import Foundation

let n = Int(readLine()!)!

var dict: [String: Int] = [:]
var weight: Int = 9
var result: Int = 0

for _ in 0..<n {
    let tempList = readLine()!.map { String($0) }

    for i in 0...tempList.count - 1 {
        dict[tempList[i], default: 0] += Int(pow(10.0, Double(tempList.count - 1 - i)))
    }
}

dict.values.sorted { $0 > $1 }.forEach {
    result += $0 * weight
    weight -= 1
}

print(result)
