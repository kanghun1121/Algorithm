import Foundation

var result = 0
var firstTrig = true
let firstLine = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n, m) = (firstLine[0], firstLine[1])

let location = readLine()!.split(separator: " ").map { Int(String($0))! }

let plusLocation = location.filter { $0 > 0 }.sorted(by: >)
let minusLocation = location.filter { $0 < 0 }.sorted(by: <)

var resultLocation: [Int] = []

for i in stride(from: 0, to: minusLocation.count, by: m) {
    resultLocation.append(minusLocation[i])
}

for i in stride(from: 0, to: plusLocation.count, by: m) {
    resultLocation.append(plusLocation[i])
}

resultLocation.map { abs($0) }.sorted(by: >).forEach {
    if firstTrig {
        result += $0
        firstTrig.toggle()
    } else {
        result += $0 * 2
    }
}

print(result)
